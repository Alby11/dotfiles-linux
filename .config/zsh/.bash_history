
#!/bin/sh
GITHUB_USERNAME="alby11"
# Install needed apt packages
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y     software-properties-common fontconfig     apt-file curl wget net-tools rsync fzf unzip openssh-client git     python3-pip python3-dev python3-neovim python3-autopep8 flake8     build-essential cmake mono-complete gccgo-go default-jdk     vim neovim libnvtt-bin ranger     zsh     ;
sudo apt upgrade -y
sudo apt autoremove -y
# PIP modules 
python3 -m pip install --upgrade pip
python3 -m pip install     pynvim     sqlparse     cmake-format     chardet     ;
# Go modules
go get -v -u     golang.org/x/tools/gopls     mvdan.cc/sh/cmd/shfmt     ;
# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Node.js (latest LTS) with NVM
nvm install --lts
# Node.js packages
npm install -g     js-beautify     eslint     remark-cli     fixjson     ;
# SSH keys setup
if [ ! -e ~/.ssh/id_ed25519 ]; then     mkdir -p ~/.ssh;     ssh-keygen -t ed25519 -b 4096; fi
nvim $HOME/.ssh/id_ed25519.pub -c 'sp $HOME/.ssh/id_ed25519'
if grep -qi Microsoft /proc/version; then   echo "Ubuntu on Windows";   sudo add-apt-repository -y ppa:appimagelauncher-team/daily;   sudo apt update;   sudo apt install -y       ubuntu-wsl wslu       appimagelauncher gnome-keyring libsecret-1-0       ;   sudo update-binfmts --disable cli # without this, wslpath and wslvar won't work
  PROFILEFILES=$(wslpath "$(wslvar USERPROFILE)/OneDrive/profileFiles"); else   echo "Native Linux";   cd ~;   git clone git@github.com:Alby11/profileFiles.git;   PROFILEFILES=~/.profileFiles; fi
# VIM\NEOVIM config
rm -rf ~/.config/nvim
rm -rf ~/.vimrc ~/.vim/
rm -rf ~/.local/share/nvim
mkdir -p ~/.config
mkdir -p ~/.local/share/nvim
ln -sf $PROFILEFILES/nvim ~/.config/
ln -sf ~/.config/nvim/init.vim ~/.vimrc
ln -sf -T ~/.local/share/nvim ~/.vim
ln -sf -T ~/.config/nvim/spell ~/.vim/spell
nvim -c 'so ~/.config/nvim/pluginsConfigFiles/plugins.vim' -c PlugInstall -c PlugClean! -c qa!
# Git Settings
git config --global user.name "alby11"
git config --global user.email 17138674+Alby11@users.noreply.github.com
git config --global core.autocrlf false
git config --global core.fsmonitor true
git config --global credential.helper manager-core
git config --global core.editor nvim
git config --global core.editor.nvim.path "/usr/bin/nvim"
git config --global diff.tool nvim
git config --global diff.tool.nvim.path "/usr/bin/nvim"
git config --global diff.tool.nvim.cmd "nvim -d \"$LOCAL\" \"$REMOTE\""
git config --global core.fsmonitor true
# Chezmoi
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --ssh --apply $GITHUB_USERNAME
# Starship
curl -sS https://starship.rs/install.sh | sh
ln -sf $PROFILEFILES/starship.toml ~/.config/starship.toml
fc-cache -f -v
chsh -s /bin/zsh
source ~/.zshrc
zsh
