### SOURCING/EXPORTING UTILITIES
export ZSH_CONFIG_HOME="$HOME/.config/zsh"
export function SOURCE_RCFILE()
{
  if [ -f $1 ]
  then
    source $1
    echo "$1 successfully sourced ... "
    return
  fi
  echo "$1 not sourced ... "
}
export function EXPORT_DIR()
{
  if [ -d $1 ] 
  then
    export PATH=$1:$PATH
    echo "$1 successfully exported ... "
    return
  fi
  echo "$1 not exported ... "
}

# dot fetch origin main ; dot diff --quiet main main || echo 'directory differ'

# set up environment, depending on os
if grep -qi microsoft /proc/version
then
  echo "ubuntu on wsl"
  [ ! -d ~/.wp ] && ln -s $(wslpath "$(wslvar userprofile)") ~/.wp
  export PROFILEFILES=$(wslpath "$(wslvar onedriveconsumer)/profilefiles")
  ln -sf $PROFILEFILES ~/
  export PROFILEFILES=~/profilefiles
  # tmux
  # win32yank_exe="/mnt/c/programdata/scoop/apps/neovim-nightly/current/bin/win32yank.exe"
  win32yank_exe=$(wslpath "$(wslvar programdata)")/scoop/shims/win32yank.exe
  if [ -e $win32yank_exe ] && [ ! -f /usr/local/bin/win32yank.exe ]
  then
    sudo ln -s $win32yank_exe "/usr/local/bin/win32yank.exe"
  fi
elif grep -qi ubuntu /proc/version ; then
  echo "native ubuntu linux"
  if [ -d ~/profilefiles ]
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

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# zsh_exports
SOURCE_RCFILE $ZSH_CONFIG_HOME/.zsh_exports

# zsh_aliases
SOURCE_RCFILE $ZSH_CONFIG_HOME/.zsh_aliases

### Initialize Starship
[ -f $PROFILEFILES/starship/starship.toml ] && \
  export STARSHIP_CONFIG=$PROFILEFILES/starship/starship.toml && \
  eval "$(starship init zsh)"
