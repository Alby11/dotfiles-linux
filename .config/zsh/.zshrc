#!/usr/bin/env zsh
# .zshrc

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

export XDG_CONFIG_HOME="$HOME/.config"
# export zsh config directory
export ZSH_CONFIG_HOME="$HOME/.config/zsh"
export ZDOTDIR=$ZSH_CONFIG_HOME
# export oh-my-zsh config directory
export ZSH="$ZSH_CONFIG_HOME/ohmyzsh"

# Basic auto/tab complete:
autoload -Uz compinit
# zstyle ':completion:*' menu select
# zmodload zsh/complist
compinit
# _comp_options+=(globdots)		# Include hidden files.
# autoload -Uz promptinit && promptinit # && prompt pure

### ANTIDOTE
SOURCE_RCFILE $ZSH_CONFIG_HOME/.antidoterc

# Exports
SOURCE_RCFILE $ZSH_CONFIG_HOME/exports.sh

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
SOURCE_RCFILE $ZSH_CONFIG_HOME/aliases.sh
# Functions
SOURCE_RCFILE $ZSH_CONFIG_HOME/functions.sh
for f in $ZSH_CONFIG_HOME/functions/*
do
  SOURCE_RCFILE $f
done

# load ssh after each reboot (re-uses same ssh-agent instance)
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

# Welcome message
if command -v neofetch &> /dev/null; then neofetch; fi
# userName=$( echo "user  $(whoami)" | figlet -o -k -c -f small )
# computerName=$( echo "on  $(cat /etc/hostname)" | figlet -o -k -c -f small )
# shellName=$( echo "with  $SHELL" | figlet -o -k -c -f small )
# theDate=$( date +"%a %y%m%d" | figlet -o -k -c -f small )
# theTime=$( date +"%X %Z" | figlet -o -k -c -f small )
# echo $userName | lolcat
# echo $computerName | lolcat
# echo $shellName | lolcat
# echo $theDate | lolcat
# echo $theTime | lolcat
if [  $(command -v fortune) ] && [ $(command -v cowsay) ] ; then fortune | cowsay ; fi
cd ~
