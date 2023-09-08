#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

echocat '.zshrc - Zsh file loaded on interactive shell sessions.'

### GIT CONFIG
git config --global core.autocrlf false
git config --global core.fsmonitor false
git config --global credential.helper manager-core
git config --global init.default.branch main
git config --global core.editor less
git config --global core.editor.less.path "$(which less)"
git config --global core.editor.less.cmd "less -R"
git config --global core.editor nvim
git config --global core.editor.nvim.path "$(which nvim)"
git config --global core.editor.nvim.cmd "nvim"
git config --global diff.tool less
git config --global diff.tool.less.path "$(which less)"
git config --global diff.tool.less.cmd "less -R \"$local\" \"$remote\""
git config --global diff.tool nvim
git config --global diff.tool.nvim.path "$(which nvim)"
git config --global diff.tool.nvim.cmd "nvim -d \"$local\" \"$remote\""
git config --global core.pager less
git config --global core.pager.less.path "$(which less)"
git config --global core.pager.less.cmd 'less -R'
git config --global core.pager nvim
git config --global core.pager.nvim.path "$(which nvim)"
git config --global core.pager.nvim.cmd "$(which nvim) -c 'Man!' -o -"
### END OF GIT CONFIG

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


# dot fetch origin main ; dot diff --quiet main main || echo 'directory differ'
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
[ -d ~/gitdepot ] && gitdepot=~/gitdepot

# TTY theme
SOURCE_RCFILE $ZDOTDIR/catppuccin_tty/src/mocha.sh
# SOURCE_RCFILE $gitdepot/dracula_tty/dracula-tty.sh

# ZSH syntax highlighting
SOURCE_RCFILE $ZDOTDIR/catppuccin_zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
# SOURCE_RCFILE $ZDOTDIR/dracula_zsh-syntax-highlighting/zsh-syntax-highlighting.sh

# ZSH interactive cd
SOURCE_RCFILE $ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# KUBECONFIG
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config:$HOME/.kube/configs/kubeconfig.yaml

# if present, source FZF
if command -v fzf &>/dev/null
then
  if command -v antidote &>/dev/null
  then
    antidote bundle "https://github.com/unixorn/fzf-zsh-plugin" | echocat
  elif [ -f $HOME/.fzf.zsh ]
  then
    SOURCE_RCFILE $HOME/.fzf.zsh
  fi
  export FZF_BASE="$(which fzf)"
  export FZF_DEFAULT_COMMAND='rg --ignore-case --files --no-ignore-vcs --hidden '
  # catppucin theme
  export FZF_DEFAULT_OPTS=" --preview bat --border=rounded \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 "
fi

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
