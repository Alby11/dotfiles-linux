#!/bin/bash
shopt -s expand_aliases

installPackets ()
{
  arr="($@)"
  for i in ${arr[@]}
  do
    packinstall $i
  done
}
alias pipinstall='sudo python3 -m pip install '

### set up environment, depending on os
if find /dev -iname '*vmware*' &> /dev/null
then
  echo "Linux on VMware"
elif grep -qi microsoft /proc/version
then
  echo "Linux on wsl"
fi
if [ -e /etc/fedora-release ] ; then
  echo "Fedora Linux"
  alias packinstall='sudo dnf install -y '
  alias packuninstall='sudo dnf autoremove -y '
  alias packupdate='sudo dnf check-update '
  alias packupgrade='sudo dnf upgrade -y '
	family='d'
	### FLATPACK
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo flatpak install org.gnome.Extensions
  ### RPM FUSION
  packinstall \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  packinstall \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
else
	if grep -qi ubuntu /proc/version ; then
	  echo "Ubuntu Linux"
	elif grep -qi pop-os /proc/version ; then
	  echo "Pop-OS Linux"
	fi
  alias packinstall='sudo apt-get install -y '
  alias packuninstall='sudo apt-get autoremove -y '
  alias packupdate='sudo apt-get update '
  alias packupgrade='sudo apt-get upgrade -y '
	family='r'
  ## Package manager stuff
  declare -a packets=(
    apt-file \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    ) 
  installPackets "${packets[@]}"
fi

read -p $'What kind of installation is it?\np=pysical\ns=virtual\ns=server\n: ' environment  
read -p $'Please insert your GitHub username: ' gitHubUser  
read -p $'Please insert your GitHub email: ' gitHubEmail  

# Neovim nightly
packuninstall neovim python3-neovim

if [ $family == 'd' ]
then
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
elif [ $family == 'r' ]
then
  sudo dnf copr enable -y agriffis/neovim-nightly
fi
declare -a packets=(
  "neovim"
  "python3-neovim"
)
installPackets "${packets[@]}"

###  SSH SETUP
declare -a packets=(
  "openssh-client"
  "sshfs"
  )
installPackets "${packets[@]}"
if [ ! -e ~/.ssh/id_ed25519 ] ; then
  mkdir -p ~/.ssh
  ssh-keygen -t ed25519 -b 4096
fi
nvim ~/.ssh/id_ed25519.pub -c 'sp ~/.ssh/id_ed25519'

# fundamentals
sudo dnf group install "C Development Tools and Libraries" "Development Tools"
declare -a packets=(
  "software-properties-common"
  "curl"
  "wget"
  "net-tools"
  "nmap"
  "tcpdump"
  "rsync"
  "gzip"
  "unzip"
  "p7zip"
  "p7zip-plugins"
  "unrar"
  "build-essential"
  "cmake"
  "yarn"
  "default-jdk"
  "dropbox"
  "nautilus-dropbox"
  "gnupg"
  "gpg"
  "chafa"
  "exiftool"
  "xdg-utils"
  "neofetch"
  "tldr"
  "cmatrix"
  "trash-cli"
  "autojump"
  "progress"
  "ncdu"
  "ansible"
)
installPackets "${packets[@]}"
if [ $environment == "p" ]
then
declare -a packets=(
  "pkg-config"
  "libfreetype6-dev"
  "libfontconfig1-dev"
  "libxcb-xfixes0-dev"
  "libxkbcommon-dev"
  "chrome-gnome-shell"
  "x11-xserver-utils"
  "gnome-tweaks"
)
installPackets "${packets[@]}"
fi

### GIT
# git official repo
if [ $family == 'd' ]
then
  sudo add-apt-repository -y ppa:git-core/ppa
elif [ $family == 'r' ]
then
  echo
fi
uninstall git
packinstall git 
git config --global user.name $gitHubUser
git config --global user.email $gitHubEmail
unset $gitHubUser
unset $gitHubEmail
git config --global core.autocrlf false
git config --global credential.helper manager-core
git config --global core.editor nvim
git config --global core.editor.nvim.path "/usr/bin/nvim"
git config --global diff.tool nvim
git config --global diff.tool.nvim.path "/usr/bin/nvim"
git config --global diff.tool.nvim.cmd "nvim -d \"$local\" \"$remote\""
git config --global init.default.branch main
git config --global core.fsmonitor false


### CARGO
packinstall cargo
export PATH=$HOME/.cargo/bin:$PATH
if $family = 'd'
  cargo install \
    bat \
    exa \
    zoxide \
    ;
fi
bat cache --build

### PIP
declare -a packets=(
  "python3"
  "python3-venv"
  "python3-dev"
  "python3-pip"
)
installPackets "${packets[@]}"
pipinstall pip
pipinstall virtualenv
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 60
sudo update-alternatives --auto python

### export user bin dir to PATH
export PATH=$HOME/.local/bin:$PATH

### NODEJS
# LTS
if [ $family == 'd' ]
then
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - 
elif [ $family == 'r' ]
then
  echo
fi
uninstall nodejs npm
packinstall nodejs
# node.js packages
sudo npm install -g \
  tree-sitter-cli \
  ;

### NEOVIM
# Glow repo
if [ $family = 'd' ]
then
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key | \
    sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | \
    sudo tee /etc/apt/sources.list.d/charm.list
elif [ $family = 'r' ]
then
  dnf copr enable tokariew/glow
fi
packupdate
packinstall \
  libnvtt-bin fzf locate ripgrep fd-find glow luarocks golang-go compose \
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

### PROMPT
declare -a packets=(
  "figlet"
  "lolcat"
)
installPackets "${packets[@]}"
# STARSHIP
curl -ss https://starship.rs/install.sh | sh

### Fonts
# Nerd Fonts
declare -a fonts=(
  CascadiaCode
  FiraCode
  FiraMono
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
packinstall zsh

### TMUX
# trzsz-go repo
if [ $family == 'd' ]
then
  echo
  # sudo add-apt-repository -y ppa:trzsz/ppa
elif [ $family == 'r' ]
then
  echo
fi
declare -a packets=(
  "tmux"
  "tmuxinator"
  "tmux-plugin-manager"
  "powerline"
  "urlview"
  "xsel"
  "xclip"
  "wl-clipboard"
)
installPackets "${packets[@]}"
pipinstall --upgrade trzsz

### RANGER
declare -a packets=(
  "ranger"
)
installPackets "${packets[@]}"
pipinstall ranger-tmux

# apt-get upgrade and cleanup
packupgrade
packuninstall
echo "alias sudo='sudo '" | sudo tee -a /etc/bash.bashrc

### DOTFILES
rm -rf ~/.dotfiles_git ~/.bash*
gistURL="https://gist.githubusercontent.com/Alby11/1843ee8b77631dbd550ab79675fbc27f/raw/89b418cbf8269ee78fb067f742fb92806c55a17a/.setup_dotfiles.sh"
OUT="$(mktemp)"; wget -q -O - $gistURL > $OUT; . $OUT
dotfilesRestore git@github.com:Alby11/dotfiles-linux.git
dotfiles pull --force
dotfiles submodule init 
dotfiles submodule update --init 

if [ $environment -eq 'p' ] ; then
### INTERCEPTION # key ramapping
  if [ $family = 'd' ]
  then
    sudo add-apt-repository -y ppa:deafmute/interception
  elif [ $family = 'r' ]
  then
	  sudo dnf copr enable fszymanski/interception-tools
  fi
  packupdate
  packinstall interception-tools
  sudo mkdir -p /etc/interception
  sudo cp .config/interception/udevmon.yaml /etc/interception
  sudo cp .config/interception/udevmon.service /etc/systemd/system
  cd gitdepot/interception-vimproved
  make && sudo make install
  sudo cp /usr/bin/intercept /usr/bin/interception
  sudo systemctl enable udevmon.service
  sudo systemctl start udevmon.service
### GPASTE
  declare -a packets=(
    "gpaste"
    "gnome-shell-extension-prefs"
  )
  installPackets "${packets[@]}"
  wget http://wgetpaste.zlin.dk/wgetpaste-current.tar.bz2
  tar xvfj wgetpaste-current.tar.bz2
  find . -type f -iname wgetpaste 2>/dev/null | xargs -I {} mv '{}' ~/.local/bin
  sudo chmod +x ~/.local/bin/wgetpaste 
  rm -rf wgetpaste*
fi
sudo dnf groupinstall -y multimedia
declare -a packets=(
  "intel-media-driver"
  "libva"
  "libva-utils"
  "gstreamer1-vaapi"
  "ffmpeg"
  "intel-gpu-tools"
  "mesa-dri-drivers"
  "mpv"
)
installPackets "${packets[@]}"
echo "options i915 enable_guc=3"  | sudo tee -a /etc/modprobe.d/1915.conf
echo "options i915 enable_fbc=1"  | sudo tee -a /etc/modprobe.d/1915.conf
sudo dracut --force
gsettings set org.gnome.desktop.interface show-battery-percentage true
packinstall tlp tlp-rdw
sudo systemctl enable tlp.service
sudo systemctl start tlp.service
dnf install -y stacer
# Launch ZSH Shell
chsh -s /bin/zsh
zsh
