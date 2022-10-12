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

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# zsh_exports
SOURCE_RCFILE $ZSH_CONFIG_HOME/.zsh_exports

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

# zsh_aliases
SOURCE_RCFILE $ZSH_CONFIG_HOME/.zsh_aliases
