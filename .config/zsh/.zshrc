### SOURCING/EXPORTING UTILITIES
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

# export zsh config directory
export ZSH_CONFIG_HOME="$HOME/.config/zsh"
export ZDOTDIR=$ZSH_CONFIG_HOME

### ANTIGEN
# SOURCE_RCFILE $ZSH_CONFIG_HOME/.zsh_antigenrc

### ANTIDOTE
SOURCE_RCFILE $ZSH_CONFIG_HOME/antidoterc

# Basic auto/tab complete:
# autoload -U compinit
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)		# Include hidden files.

# Exports
SOURCE_RCFILE $ZSH_CONFIG_HOME/exports

### Initialize Zoxide
if command -v zoxide &> /dev/null
then
  eval "$(zoxide init zsh)" 
fi

### Initialize Starship
if command -v starship &>/dev/null
then
  eval "$(starship init zsh)"
fi

# dot fetch origin main ; dot diff --quiet main main || echo 'directory differ'
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

# Aliases
SOURCE_RCFILE $ZSH_CONFIG_HOME/aliases


# Welcome message
if command -v neofetch &> /dev/null; then neofetch; fi
# userName=$( echo "user  $(whoami)" | figlet -o -k -c -f small )
# computerName=$( echo "on  $(cat /etc/hostname)" | figlet -o -k -c -f small )
# shellName=$( echo "with  $SHELL" | figlet -o -k -c -f small )
theDate=$( date +"%a %y%m%d" | figlet -o -k -c -f small )
theTime=$( date +"%X %Z" | figlet -o -k -c -f small )
echo $userName | lolcat
echo $computerName | lolcat
echo $shellName | lolcat
echo $theDate | lolcat
echo $theTime | lolcat
