#!/bin/env zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

echocat '.zshrc - Zsh file loaded on interactive shell sessions.'

# Zsh options.
setopt extended_glob

# Initialize the Zsh completion system
# This enables advanced command-line completion features
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-$HOME}/.zstyles ]] && SOURCE_RCFILE ${ZDOTDIR:-~}/.zstyles

# Source GIT configuration
SOURCE_RCFILE $XDG_CONFIG_HOME/git/.git.conf

# Create an amazing Zsh config using antidote plugins.
# Set the path to the Oh My Zsh installation directory
SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
if command -v antidote &>/dev/null; then
  SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.zsh_plugins.conf
  antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
  rm -f ${ZDOTDIR:-$HOME}/.zsh_plugins.zsh #rm static file
  SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.zsh_plugins.post
else
  echocat "A plugin manager is either:\n \
    not installed\n \
    present in PATH\n \
    not configured\n \
    not working\n \
    ;"
fi

# Basic auto/tab complete:
autoload -Uz compinit && zmodload zsh/complist ; compinit
_comp_options+=(globdots)		# Include hidden files.

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# export TERM color variable for Neovim inside Tmux
export TERM="xterm-256color"

# export COLORTERM to make most detect 24 bit truecolor
COLORTERM=truecolor

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set ZSH as VSCode default shell for the integrated terminal
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

### GITHUB repos exports
[ -d $HOME/gitdepot ] && gitdepot=$HOME/gitdepot

# TTY theme
SOURCE_RCFILE $ZDOTDIR/catppuccin_tty/src/mocha.sh
# SOURCE_RCFILE $gitdepot/dracula_tty/dracula-tty.sh

# ZSH syntax highlighting
SOURCE_RCFILE $ZDOTDIR/catppuccin_zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
# SOURCE_RCFILE $ZDOTDIR/dracula_zsh-syntax-highlighting/zsh-syntax-highlighting.sh

# ZSH interactive cd
# SOURCE_RCFILE $ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# KUBECONFIG
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config:$HOME/.kube/configs/kubeconfig.yaml

### Initialize Zoxide
if command -v zoxide &> /dev/null
then
  # eval "$(zoxide init zsh)"
fi

### Initialize Starship
if command -v starship &>/dev/null
then
  eval "$(starship init zsh)"
fi

### SSH BLOCK
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
cd $HOME
