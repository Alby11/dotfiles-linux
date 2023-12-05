#!/bin/env zsh
#
# .zshrc
#

ECHOCAT """
.zshrc - Zsh file loaded on login/non-login shell sessions.
login: after .zprofile and before .zlogin
non-login: after .zshenv
"""

# Zsh options.
setopt extended_glob

# Initialize the Zsh completion system
# This enables advanced command-line completion features
autoload -Uz compinit && zmodload zsh/complist ; compinit
_comp_options+=(globdots) # With hidden files
autoload -Uz promptinit && promptinit

### Set up ZSH Autocomplete
# Credits:
# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/completion.zsh
# SOURCE_RCFILE $ZDOTDIR/.zcompletion.zsh

# Source zstyles you might use with antidote.
SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.zstyles

# Source GIT configuration
SOURCE_RCFILE $XDG_CONFIG_HOME/git/.git.conf

#
# Editors
#
SOURCE_RCFILE $ZDOTDIR/.zeditor

#
# Xresources
#
SOURCE_RCFILE $ZDOTDIR/.zxresources.zsh

### NPM
if ! CHECK_COMMANDS "npm"; then
  package_manager_install npm
fi
  
# Create an amazing Zsh config using antidote plugins.
# Set the path to the Oh My Zsh installation directory
if [ -d $ZDOTDIR/.antidote ]; then
  SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
else
  git clone --depth=1 https://github.com/mattmc3/antidote.git \
    ${ZDOTDIR:-~}/.antidote && \
    SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
fi
if CHECK_COMMANDS "antidote"; then
  SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.zsh_plugins.conf
  antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
  SOURCE_RCFILE ${ZDOTDIR:-$HOME}/.zsh_plugins.post
else
  FAIL "A ZSH plugin manager is either: \
    not installed \
    present in PATH \
    not configured \
    not working \
    ;"
fi

#
# FPATH AUTOLOAD
#
# Define the directories that contain your functions
local FUNCTION_DIRS=("$ZDOTDIR/functions")
# Loop through the directories and add each one to fpath
for dir in "${FUNCTION_DIRS[@]}"; do
  if [[ -d $dir ]]; then
    fpath=( $dir "${fpath[@]}" )
  fi
done
# Get a list of all files in the directories
for dir in "${FUNCTION_DIRS[@]}"; do
  if [[ -d $dir ]]; then
    ECHOCAT "Autoloading functons in: $dir"
    func_files=($dir/*)
    # Loop through the files and autoload each one
    for func in $func_files; do
      autoload -Uz $func
    done
  fi
done
### END OF FPATH AUTOLOAD

# Define the directories that contain your completion functions
FUNCTION_DIRS=("$ZDOTDIR/completions")
# Get a list of all files in the directories
for dir in "${FUNCTION_DIRS[@]}"; do
  if [[ -d $dir ]]; then
    ECHOCAT "Sourcing autocomplete functons in: $dir"
    func_files=($dir/*)
    # Loop through the files and source each one
    for func in $func_files; do
      source $func
      # call complete command for the corrisponding and
      # previously sourced zsh function script
      complete -F $(basename $func) $(basename $func | sed -s 's/^.//')
    done
  fi
done
### END OF COMPLETION FUNCTIONS SOURCING

# Uncomment the following line to enable command auto-correction.
export ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
export COMPLETION_WAITING_DOTS="true"

# Set the name and location of the history file
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"

# Uncomment the following line if you want to change the command execution time
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
export HIST_STAMPS="yyyy-mm-dd"

# export TERM color variable for Neovim inside Tmux
export TERM="xterm-256color"

# export COLORTERM to make most detect 24 bit truecolor
export COLORTERM=truecolor

# set Ls_COLORS if vivid is installed
if CHECK_COMMANDS "vivid"; then
  export LS_COLORS="$(vivid generate catppuccin-mocha)"
fi

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))

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

### Initialize Starship
if [[ ! $( command -v starship ) ]]; then
  curl -sSv 'https://starship.rs/install.sh' | sh
fi
if [[ $(whoami) == 'root' ]]; then
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/root_starship.toml"
else
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/user_starship.toml"
fi
eval "$(starship init ${THE_SHELL})"

### SSH BLOCK
### LOAD SSH AFTER EACH REBOOT (RE-USES SAME SSH-AGENT INSTANCE)
if [[ ! $( command -v keychain ) ]]; then
  package_manager_install keychain
fi
export SSH_ENV="$HOME/.ssh/agent-environment"
start_agent() {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  # /usr/bin/ssh-add;
  for file in $HOME/.ssh/id_* ; do
    if [[ $(ls $file | grep pub ) ]]; then continue ; fi
    eval $(keychain --quiet --eval $file > /dev/null)
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
unset -f start_agent
### END OF SSH BLOCK
