#!/bin/env zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

export THE_SHELL="$(echo $SHELL | grep -o '[^\/]*$')"

# use lolcat as a special echo command
export ECHOCAT() {
  if command -v lolcat &>/dev/null; then
    if  lolcat --version | grep -E 'moe@busyloop.net' &>/dev/null; then
      alias lolcat='lolcat -ta'
    else
      alias lolcat='lolcat -b'
    fi
      echo "$1" | lolcat `[[ -n "$2" ]] && echo "$2"`
      unalias lolcat
  else
      echo "$1"
  fi
}

# This function checks if the given commands are available on the system.
# It takes an array of command names as an argument.
# Each command name should be a separate argument.
# You can pass an array variable or directly pass an array as arguments.
#
# Usage:
#   CHECK_COMMANDS "${array[@]}"  # Pass array variable
#   CHECK_COMMANDS "cmd1" "cmd2" "cmd3"  # Directly pass an array
#
#   if CHECK_COMMANDS "fzf" "fd" "head" "bat"; then
#     echo "All commands are available."
#   else
#     echo "Some commands are missing."
#   fi
# The function will return a success status if all commands are available,
# or a failure status if any command is not found.

export CHECK_COMMANDS() {
  local cmds=("$@")  # Store the arguments in an array
  for cmd in "${cmds[@]}"; do  # Iterate over each command
    if ! command -v "$cmd" > /dev/null 2>&1; then  # Check if the command is available
      ECHOCAT "Error: Required command '$cmd' not found. Please install it and try again."
      return 1  # Return a failure status
    fi
  done
  return 0  # Return a success status
}

# ECHOCAT '.zshenv - Zsh environment file, loaded always.'

### SOURCING/EXPORTING UTILITIES
export SOURCE_RCFILE() {
    if [ -f "$1" ]; then
        source "$1"
        ECHOCAT "$1 successfully sourced ... "
    else
        ECHOCAT "$1 not sourced ... " -i
    fi
}
export EXPORT_DIR() {
    if [ -d $1 ]; then
      export PATH=$1:$PATH
      ECHOCAT "$1 successfully exported ... "
    else
      ECHOCAT "$1 not exported ... " -i
    fi
}

# fiexport XDG_CONFIG_HOME="$HOME/.config"
# Set ZDOTDIR if you want to re-home Zsh.
# export ZSH_CONFIG_HOME="$HOME/.config/zsh"
# export ZDOTDIR=$ZSH_CONFIG_HOME
# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
# Set omz variables prior to loading omz plugins
# see issue https://github.com/ohmyzsh/ohmyzsh/issues/11762
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p $ZSH_CACHE_DIR/completions

#
# Editors
#
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"
export PAGER="${PAGER:-less}"
export MANPAGER="${MANPAGER:-$PAGER}"
### Setting up less
# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"
if command -v lesspipe.sh &>/dev/null; then
  lesspipe.sh | source /dev/stdin
else
  ECHOCAT 'LESSOPEN: lesspipe.sh in not installed or in PATH' -i
fi

if command -v bat &>/dev/null; then
  export LESSCOLORIZER="bat --style=full --theme=catppuccin-mocha"
fi
if command -v batpipe &>/dev/null; then
  # To use batpipe, eval the output of this command in your shell init script.
  export LESSOPEN="|$(which batpipe) %s"
  export LESSOPEN
  unset LESSCLOSE
  # The following will enable colors when using batpipe with less:
  export LESS="$LESS -R"
  export BATPIPE="color"
  export LESS
  export BATPIPE
fi

#
# Paths
#

## You can use .zprofile to set environment vars for non-login, non-interactive shells.
# if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprofile"
# fi

# Some people insist on setting their PATH here to affect things like ssh.
# Those that do should probably use $SHLVL to ensure that this only happens
# the first time the shell is started (to avoid overriding a customized
# environment).  Also, the various profile/rc/login files all get sourced
# *after* this file, so they will override this value.  One solution is to
# put your path-setting code into a file named .zpath, and source it from
# both here (if we're not a login shell) and from the .zprofile file (which
# is only sourced if we are a login shell).
if [[ $SHLVL == 1 && ! -o LOGIN && -f $ZDOTDIR/.zpath ]]; then
    source $ZDOTDIR/.zpath
fi
