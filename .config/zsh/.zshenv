#!/bin/env zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

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

export THE_SHELL="$(echo $SHELL | grep -o '[^\/]*$')"

# use lolcat as a special printf command
export ECHOCAT() {
  if command -v lolcat &>/dev/null; then
    if  lolcat --version | grep -E 'moe@busyloop.net' &>/dev/null; then
      alias lolcat='lolcat -ta'
    else
      alias lolcat='lolcat -b'
    fi
    # printf "%s" "$1" | lolcat `[[ -n "$2" ]] && printf "%s" "$2"`
    printf "%s\n" "$1" | lolcat `[[ -n "$2" ]] && printf "%s" "$2"`
    unalias lolcat
  else
    printf "%s\n" "$1"
  fi
}

ECHOCAT ".zshenv - Zsh environment file, loaded always. SHLVL $SHLVL"

# Function to print an error message and exit/return with an error/return code
export FAIL() {
  if [[ -z "$2" ]]; then
    ECHOCAT "$1" -i # Print the first argument as a message using ECHOCAT
  elif [[ "$2" == "x" ]]; then
    ECHOCAT "$1" >&2 -i # Print the first argument as an error message using ECHOCAT
    exit "${3-1}"  # Exit with the third argument as the error code, or 1 if no third argument is provided
  elif [[ "$2" == "r" ]]; then
    ECHOCAT "$1" >&2 -i # Print the first argument as an error message using ECHOCAT
    return "${3-1}"  # Return with the third argument as the error code, or 1 if no third argument is provided
  else
    echo "Error: Invalid second argument to FAIL function. Expected 'r', 'x', or empty, got '$2'." -i
    return 1
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
      FAIL "Error: Required command '$cmd' not found. Please install it and try again." r 1 # Return a failure status
    fi
  done
  return 0  # Return a success status
}

### SOURCING/EXPORTING UTILITIES
export SOURCE_RCFILE() {
    if [ -f "$1" ]; then
        source "$1"
        ECHOCAT "$1 successfully sourced ... "
    else
        FAIL "$1 not sourced ... "
    fi
}
export EXPORT_DIR() {
    if [ -d $1 ]; then
      export PATH=$1:$PATH
      ECHOCAT "$1 successfully exported ... "
    else
      FAIL "$1 not exported ... "
    fi
}

# fiexport XDG_CONFIG_HOME="$HOME/.config"
# Set ZDOTDIR if you want to re-home Zsh.
# export ZSH_CONFIG_HOME="$HOME/.config/zsh"
# export ZDOTDIR=$ZSH_CONFIG_HOME
# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

#
# Paths
#

## You can use .zprofile to set environment vars for non-login, non-interactive shells.
 if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
   SOURCE_RCFILE "${ZDOTDIR:-$HOME}/.zprofile"
fi

