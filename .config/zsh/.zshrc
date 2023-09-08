#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

echo '.zshrc - Zsh file loaded on interactive shell sessions.'

# Zsh options.
setopt extended_glob

# Initialize the Zsh completion system
# This enables advanced command-line completion features
autoload -Uz compinit && compinit

# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Set the path to the Oh My Zsh installation directory
export ZSH=${ZSH:-$ZDOTDIR/.oh-my-zsh}


# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

### SOURCING/EXPORTING UTILITIES
export function echocat() {
    if [ -x "$(command -v lolcat)" ]; then
      if  lolcat --version | grep -E 'moe@busyloop.net' &>/dev/null
      then
        alias lolcat='lolcat -ta'
      else
        alias lolcat='lolcat -b'
      fi
        echo "$1" | lolcat
        unalias lolcat
    else
        echo "$1"
    fi
}

export function SOURCE_RCFILE() {
    if [ -f "$1" ]; then
        source "$1"
        echocat "$1 successfully sourced ... "
    else
        echocat "$1 not sourced ... "
    fi
}
export function EXPORT_DIR()
{
    if [ -d $1 ]
    then
      export PATH=$1:$PATH
      echocat "$1 successfully exported ... "
    else
    echocat "$1 not exported ... "
    fi
}

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# Basic auto/tab complete:
# autoload -Uz compinit
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)		# Include hidden files.
# autoload -Uz promptinit && promptinit # && prompt pure


### ANTIDOTE
# SOURCE_RCFILE $ZSH_CONFIG_HOME/.antidoterc

# Exports
# SOURCE_RCFILE $ZSH_CONFIG_HOME/exports.sh

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

### LOAD SSH AFTER EACH REBOOT (RE-USES SAME SSH-AGENT INSTANCE)
if [[ ! $( command -v keychain ) ]]; then
    sudo dnf install -y keychain &> /dev/null
    sudo rpm install -y keychain &> /dev/null
    sudo apt install -y keychain &> /dev/null
fi
SSH_ENV="$HOME/.ssh/agent-environment"
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    # /usr/bin/ssh-add;
    for file in ~/.ssh/id_* ; do
        if [[ $(ls $file | grep pub ) ]]; then continue ; fi
        eval $(keychain --eval $file)
    done
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    # ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
### END OF SSH BLOCK
