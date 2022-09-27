#!/bin/sh
github_username="alby11"
# additional repos
echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' \
  | sudo tee /etc/apt/sources.list.d/charm.list
sudo add-apt-repository -y ppa:neovim-ppa/unstable
# apt extra packages
sudo apt install -y \
  apt-file \
  apt-utils \
  apt-transport-https \
  ca-certificates \
  ;
# ssh setup
sudo apt install -y \
  openssh-client \
  neovim \
  ansible sshfs \
  ;
if [ ! -e ~/.ssh/id_ed25519 ] ; then
    mkdir -p ~/.ssh
    ssh-keygen -t ed25519 -b 4096
    nvim $home/.ssh/id_ed25519.pub -c 'sp $home/.ssh/id_ed25519'
fi
# fundamentals
sudo apt install -y \
  software-properties-common \
  curl wget net-tools nmap tcpdump rsync unzip git \
  build-essential cmake yarn default-jdk \
  shfmt \
  stow \
  ;

### GIT
sudo apt install -y \
  git \
  ;
git config --global user.name "alby11"
git config --global user.email 17138674+alby11@users.noreply.github.com
git config --global core.autocrlf false
git config --global core.fsmonitor true
git config --global credential.helper manager-core
git config --global core.editor nvim
git config --global core.editor.nvim.path "/usr/bin/nvim"
git config --global diff.tool nvim
git config --global diff.tool.nvim.path "/usr/bin/nvim"
git config --global diff.tool.nvim.cmd "nvim -d \"$local\" \"$remote\""
git config --global core.fsmonitor true

# set up environment, depending on os
if grep -qi microsoft /proc/version ; then
  echo "ubuntu on wsl"
  sudo add-apt-repository -y ppa:appimagelauncher-team/daily
  # download the microsoft repository gpg keys
  wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
  # register the microsoft repository gpg keys
  sudo dpkg -i packages-microsoft-prod.deb
  sudo rm packages-microsoft-prod.deb
  sudo apt update
  sudo apt install -y \
    ubuntu-wsl wslu powershell appimagelauncher gnome-keyring libsecret-1-0 \
    ;
  sudo update-binfmts --disable cli # without this, wslpath and wslvar won't work
  mkdir ~/.wp
  ln -s $(wslpath "$(wslvar userprofile)") ~/.wp
  export PROFILEFILES=$(wslpath "$(wslvar onedriveconsumer)/profilefiles")
  ln -sf $PROFILEFILES ~/
  export PROFILEFILES=~/profilefiles
  # tmux
  # win32yank_exe="/mnt/c/programdata/scoop/apps/neovim-nightly/current/bin/win32yank.exe"
  win32yank_exe=$(wslpath "$(wslvar programdata)")/scoop/shims/win32yank.exe
  if [ -e $win32yank_exe ] ; then
    sudo ln -s $win32yank_exe "/usr/local/bin/win32yank.exe"
  fi
elif grep -qi ubuntu /proc/version ; then
  echo "native ubuntu linux"
  if [ -d ~/profilefiles ];
  then
    cd ~/profilefiles
    git pull
    cd ~
  else
    cd ~
    git clone git@github.com:alby11/profilefiles.git
  fi
  export PROFILEFILES=~/profilefiles
fi

### DOTFILES
curl -Lks \
  https://github.com/Alby11/dotfiles-linux/blob/2a559907ac59e6b8793e7069be8f33aaca2f4599/.setup_dotfiles.sh \
  | /bin/bash \
  ;

### CARGO
curl https://sh.rustup.rs -ssf | sh
export path=~/.cargo/bin:$path
cargo install --force \
  bat \
  exa \
  stylua \
  tree-sitter-cli \
  zoxide \
  ;
bat cache --build

### BREW
/bin/bash -c \
  "$(curl -fssl https://raw.githubusercontent.com/homebrew/install/head/install.sh)" \
  ;
# brew tap homebrew/cask-fonts &&
# brew install --cask font-<font name>-nerd-font

### ZNAP
[[ -f ~/git/zsh-snap/znap.zsh ]] ||
  git clone --depth 1 -- \
  https://github.com/marlonrichert/zsh-snap.git ~/git/zsh-snap \
  ;

### github repos
githubdepot=~/.githubdepot
mkdir -p $githubdepot
githubrepos=(
  "git@github.com:eth-p/bat-extras.git"
  "git@github.com:aristocratos/btop.git"
)
for r in ${githubrepos[@]}; do
  destdir=$(echo $r | cut -d \/ -f 2 | cut -d . -f 1)
  git clone $r $githubdepot/$destdir
done
# bat-extras
sudo $githubdepot/bat-extras/build.sh --install
export path=$githubdepot/bat-extras/bin:$path
# btop
sudo apt install -y \
  coreutils \
  sed \
  git \
  gcc-11 \
  g++-11 \
  ;
cd $githubdepot/btop
echo "addflags=-march=native" >> makefile
make
sudo make install
sudo make setuid
make clean && make distclean
cd ~
# golang
gopath=$githubdepot/goroot
git clone https://go.googlesource.com/go $gopath
cd $gopath
git checkout master
cd src
./all.bash
export path=$gopath/bin:$path
./clean.bash
cd ~
go install \
  golang.org/x/tools/gopls@latest \
  ;

### PIP
sudo apt install -y \
  python3 python3-pip python3-dev \
  ;
python3 -m pip install --upgrade pip
python3 -m pip install \
  autopep8 \
  black \
  chardet \
  cmake-format \
  flake8 \
  neovim \
  neovim-remote \
  pipenv \
  pylint \
  pynvim \
  pyright \
  sqlparse \
  tree_sitter \
  virtualenv \
  virtualenvwrapper \
  ;

### NVM
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
git clone https://github.com/nvm-sh/nvm.git ~/.nvm
source ~/.nvm/.nvm.sh
export nvm_dir="$home/.nvm"
[ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh"  # this loads nvm
[ -s "$nvm_dir/bash_completion" ] && \. "$nvm_dir/bash_completion"  # nvm bash_completion
# node.js (latest lts) with nvm
nvm install --lts
# node.js packages
npm install -g \
  clipboard-cli \
  eslint \
  fixjson \
  js-beautify \
  libtmux \
  neovim \
  remark-cli \
  yarn \
  ;

### NEOVIM
sudo apt install -y \
  neovim-runtime \
  libnvtt-bin fzf locate ripgrep sqlite3 libsqlite3-dev fd-find glow \
  dh-vim-addon lua-nvim lua-nvim-dev luarocks ruby-neovim vim-ale \
  ;
rm -rf ~/.config/nvim && mkdir -p ~/.config
rm -rf ~/.local/share/nvim && mkdir -p ~/.local/share/nvim
ln -sf $PROFILEFILES/nvim ~/.config/ # ln repo nvim config
nvim --headless -c 'autocmd user packercomplete quitall' -c 'packersync' -c 'qa!'
nvim --headless -c 'autocmd user packercomplete quitall' -c 'packersync'
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

### STARSHIP
curl -ss https://starship.rs/install.sh | sh
export starship_config=$PROFILEFILES/starship/starship.toml

# rebuild font cache
sudo apt install -y \
  fontconfig \
  fonts-cascadia-code \
  fonts-firacode \
  fonts-powerline \
  ;
fc-cache -f -v

### ZSH
sudo apt install -y \
  zsh \
  ;
curl -L git.io/antigen-nightly > ~/antigen.zsh 
source ~/antigen.zsh

### TMUX
sudo apt install -y \
  tmux tmuxinator powerline \
  xsel xclip wl-clipboard \ # for tmux-yank
  ;
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
mkdir -p ~/.oh-my-zsh/completions/_tmuxinator
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh \
  -o ~/.oh-my-zsh/completions/_tmuxinator \
  ;

### RANGER
sudo apt install -y \
  renger \
  ;
pip install \
  ranger-tmux \
  ;

# apt upgrade and cleanup
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autopurge -y
sudo apt autoclean -y
chsh -s /bin/zsh
source ~/.zshrc
zsh
