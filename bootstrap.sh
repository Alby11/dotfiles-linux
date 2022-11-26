#!/bin/bash

if [ ! $1 ]; then echo -e "usage: \n\nbootstrap.sh physical/server/virtual" ; exit 2 ; fi
if [ $1 == "physical" ] ; then environment="p" ; fi
if [ $1 == "server" ] ; then environment="s" ; fi
if [ $1 == "virtual" ] ; then environment="v" ; fi

# additional repos
# Neovim nightly
sudo add-apt-repository -y ppa:neovim-ppa/unstable
# git official repo
sudo add-apt-repository -y ppa:git-core/ppa
# apt-get extra packages
sudo apt-get install -y \
  apt-file \
  apt-utils \
  apt-transport-https \
  ca-certificates \
  ;

# ssh setup
sudo apt-get autoremove -y \
  neovim \
  ;
sudo apt-get install -y \
  openssh-client \
  neovim neovim-runtime \
  sshfs \
  ;
if [ ! -e ~/.ssh/id_ed25519 ] ; then
    mkdir -p ~/.ssh
    ssh-keygen -t ed25519 -b 4096
fi
nvim $home/.ssh/id_ed25519.pub -c 'sp $home/.ssh/id_ed25519'

# fundamentals
sudo apt-get install -y \
  software-properties-common \
  curl wget net-tools nmap tcpdump rsync gzip unzip \
  build-essential cmake yarn default-jdk \
  chafa exiftool xdg-utils \
  ;
if [$environment -eq "p"]; then
  sudo add-apt-repository -y ppa:aslatter/ppa
  sudo apt-get install -y \
    pkg-config \
    libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev \
    alacritty \
    chrome-gnome-shell \
    x11-xserver-utils \
    ;
fi

### GIT
sudo apt-get autoremove -y git
sudo apt-get install -y \
  git \
  ;
github_username="alby11"
git config --global user.name $github_username
unset github_username
git config --global user.email 17138674+alby11@users.noreply.github.com
git config --global core.autocrlf false
git config --global credential.helper manager-core
git config --global core.editor nvim
git config --global core.editor.nvim.path "/usr/bin/nvim"
git config --global diff.tool nvim
git config --global diff.tool.nvim.path "/usr/bin/nvim"
git config --global diff.tool.nvim.cmd "nvim -d \"$local\" \"$remote\""
git config --global init.default.branch main
git config --global core.fsmonitor false

### set up environment, depending on os
if grep -qi microsoft /proc/version
then
  echo "ubuntu on wsl"
elif grep -qi ubuntu /proc/version ; then
  echo "native ubuntu linux"
fi

### CARGO
sudo apt-get install -y cargo
export PATH=$HOME/.cargo/bin:$PATH
cargo install --force \
  bat \
  exa \
  zoxide \
  ;
bat cache --build

### PIP
sudo apt-get install -y \
  python3 python3-venv python3.11-dev python3-pip nuitka
  ;
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade \
  virtualenv \
  ;
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 60
sudo update-alternatives --auto python
export PATH=$HOME/.local/bin:$PATH

# node.js (latest lts) with nvm
sudo apt-get install -y \
  nodejs \
  npm \
  ;
# node.js packages
sudo npm install -g \
  tree-sitter-cli \
  ;

### NEOVIM
# Glow
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt-get update
sudo apt-get install -y \
  libnvtt-bin fzf locate ripgrep fd-find glow \
  ;
rm -rf ~/.config/
mkdir -p ~/.config
rm -rf ~/.local/share/nvim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --auto vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --auto vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --auto editor

### INTERCEPTION # key ramapping
if [ $environment -eq "p" ] ; then
  sudo add-apt-repository -y ppa:deafmute/interception
  sudo apt-get install -y interception-tools
  sudo mkdir -p /etc/interception
  sudo cp .config/interception/udevmon.yaml /etc/interception
  sudo cp .config/interception/udevmon.service /etc/systemd/system
  sudo systemctl enable udevmon.service
  sudo systemctl start udevmon.service
fi

### PROMPT
sudo apt-get install -y \
  figlet \
  lolcat \
  ;
# STARSHIP
curl -ss https://starship.rs/install.sh | sh

### Fonts
# Nerd Fonts
declare -a fonts=(
  CascadiaCode
  FiraCode
  FiraMono
  JetBrainsMono
  Lilex
)
version='2.2.0'
fonts_dir="${HOME}/.local/share/fonts"
if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi
for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip -o "$zip_file" -d "$fonts_dir"
    rm -f "$zip_file"
done
find "$fonts_dir" -name '*Windows Compatible*' -delete
unset fonts version fonts_dir font zip_file download_url 
# rebuild font cache
fc-cache -f -v

### ZSH
sudo apt-get install -y \
  zsh \
  ;

### TMUX
# trzsz-go
sudo add-apt-repository -y ppa:trzsz/ppa
sudo apt-get install -y \
  tmux tmuxinator tmux-plugin-manager powerline \
  xsel xclip wl-clipboard \
  trzsz \
  ;

### RANGER
sudo apt-get install -y \
  ranger \
  ;
python3 -m pip install --user --upgrade \
  ranger-tmux \
  ;

# apt-get upgrade and cleanup
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get autopurge -y
sudo apt-get autoclean -y
echo "alias sudo='sudo '" | sudo tee -a /etc/bash.bashrc
chsh -s /bin/zsh

### DOTFILES
rm -rf ~/.dotfiles_git
gistURL="https://gist.githubusercontent.com/Alby11/1843ee8b77631dbd550ab79675fbc27f/raw/89b418cbf8269ee78fb067f742fb92806c55a17a/.setup_dotfiles.sh"
OUT="$(mktemp)"; wget -q -O - $gistURL > $OUT; . $OUT
dotfilesRestore git@github.com:Alby11/dotfiles-linux.git
dotfiles pull --force

# Launch ZSH Shell
zsh
