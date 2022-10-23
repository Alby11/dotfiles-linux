#!/bin/sh
# additional repos
echo "deb https://repo.charm.sh/apt/ * *" | \
  sudo tee /etc/apt/sources.list.d/charm.list && \
  curl https://repo.charm.sh/apt/gpg.key | sudo apt-key add - \
  ; # Glow
sudo add-apt-repository -y ppa:neovim-ppa/unstable # Neovim nightly
sudo add-apt-repository -y ppa:git-core/ppa # git official repo
sudo add-apt-repository -y ppa:ansible/ansible # ansible
sudo add-apt-repository -y ppa:trzsz/ppa && sudo apt update # trzsz-go
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
  build-essential cmake yarn ninja-build default-jdk \
  chafa exiftool xdg-utils \
  shfmt \
  stow \
  ;

### GIT
sudo apt install -y \
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
  userprofile=$(wslpath "$(wslvar userprofile)")
  leaf=$(echo $userprofile | cut -d '/' -f 5)
  [ ! -L ~/$leaf ] && [ ! -e ~/$leaf ] && \
    ln -s $(wslpath "$(wslvar userprofile)") ~/ \
    ;
  [ ! -L ~/profilefiles ] && [ ! -e ~/profilefiles ] && \
    export PROFILEFILES=$(wslpath "$(wslvar onedriveconsumer)/profilefiles") && \
    ln -sf $PROFILEFILES ~/ \
    ;
  unset userprofile leaf
elif grep -qi ubuntu /proc/version ; then
  echo "native ubuntu linux"
  [ ! -d ~/profilefiles ] && \
    cd ~/profilefiles && git pull && cd ~ \
    ;
  git clone git@github.com:alby11/profilefiles.git
fi
export PROFILEFILES=~/profilefiles

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

### github repos
gitdepot=~/gitdepot
mkdir -p $gitdepot
githubrepos=(
)
for r in ${githubrepos[@]}; do
  destdir=$(echo $r | cut -d \/ -f 2 | cut -d . -f 1)
  git clone $r $gitdepot/$destdir
done
unset githubrepos r
# bat-extras
sudo $gitdepot/bat-extras/build.sh --install
export path=$gitdepot/bat-extras/bin:$path
# btop
sudo apt install -y \
  coreutils \
  sed \
  git \
  gcc-11 \
  g++-11 \
  ;
cd $gitdepot/btop
echo "addflags=-march=native" >> makefile
make
sudo make install
sudo make setuid
make clean && make distclean
cd ~
# golang
gopath=gitdepot/goroot
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
unset gitdepot gopath

### PIP
sudo apt install -y \
  python3 python3-pip python3-dev ninja-build \
  ;
python3 -m pip install --user --upgrade pip
python3 -m pip install --user --upgrade \
  autopep8 \
  black \
  chardet \
  cmake-format \
  flake8 \
  meson \
  neovim \
  neovim-remote \
  pipenv \
  pylint \
  pynvim \
  pyright \
  sqlparse \
  tree_sitter \
  trzsz \
  virtualenv \
  virtualenvwrapper \
  ;
export PATH=$HOME/.local/bin:$PATH

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
  prettier \
  remark-cli \
  yarn \
  ;
unset nvm_dir

### NEOVIM
sudo apt install -y \
  neovim-runtime \
  libnvtt-bin fzf locate ripgrep sqlite3 libsqlite3-dev fd-find glow \
  dh-vim-addon lua-nvim lua-nvim-dev luarocks ruby-neovim vim-ale \
  ;
rm -rf ~/.config/nvim && mkdir -p ~/.config
rm -rf ~/.local/share/nvim && mkdir -p ~/.local/share/nvim
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
export STARSHIP_CONFIG=~/.config/starship.toml

### Fonts
# Nerd Fonts
declare -a fonts=(
  CascadiaCode
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
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done
find "$fonts_dir" -name '*Windows Compatible*' -delete
unset fonts version fonts_dir font zip_file download_url 
# rebuild font cache
fc-cache -f -v

### ZSH
sudo apt install -y \
  zsh \
  ;

### TMUX
sudo apt install -y \
  tmux tmuxinator powerline \
  xsel wl-clipboard \ # for tmux-yank
  trzsz-go \ # for tmux and tabby
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
pip install --user --upgrade \
  ranger-tmux \
  ;

# apt upgrade and cleanup
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autopurge -y
sudo apt autoclean -y
echo "alias sudo='sudo '" | sudo tee -a /etc/bash.bashrc
chsh -s /bin/zsh
source ~/.zshrc
zsh
