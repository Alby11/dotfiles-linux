#!/usr/bin/env zsh

#
# .ztools.zsh - tools for better profiling...
#

# use lolcat as a special printf command
ECHOCAT() {
  if command -v lolcat &>/dev/null; then
    if  lolcat --version | grep -E 'moe@busyloop.net' &>/dev/null; then
      alias lolcat='lolcat'
      if [ "$2" = 'ERROR' ]; then
        alias lolcat='lolcat -a -d 50'
      fi
    else
      alias lolcat='lolcat -b'
      if [ "$2" = 'ERROR' ]; then
        alias lolcat='lolcat -bi'
      fi
    fi
    printf "%s\n" "$1" | lolcat
    unalias lolcat
  else
    printf "%s\n" "$1"
  fi
}

ECHOCAT ".ztools.zsh - tools for better profiling..."

# Function to print an error message and exit/return with an error/return code
FAIL() {
  if [[ -z "$2" ]]; then
    ECHOCAT "$1" ERROR # Print the first argument as a message using ECHOCAT
  elif [[ "$2" == "x" ]]; then
    ECHOCAT "$1" >&2 ERROR # Print the first argument as an error message using ECHOCAT
    exit "${3-1}"  # Exit with the third argument as the error code, or 1 if no third argument is provided
  elif [[ "$2" == "r" ]]; then
    ECHOCAT "$1" >&2 ERROR # Print the first argument as an error message using ECHOCAT
    return "${3-1}"  # Return with the third argument as the error code, or 1 if no third argument is provided
  else
    echo "Error: Invalid second argument to FAIL function. Expected 'r', 'x', or empty, got '$2'."
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
CHECK_COMMANDS() {
  local cmds=("$@")  # Store the arguments in an array
  for cmd in "${cmds[@]}"; do  # Iterate over each command
    if ! command -v "$cmd" > /dev/null 2>&1; then  # Check if the command is available
      FAIL "Error: Required command '$cmd' not found. Please install it and try again." r 1 # Return a failure status
    fi
  done
  return 0  # Return a success status
}

### SOURCING/EXPORTING UTILITIES
SOURCE_RCFILE() {
  if [ -f "$1" ]; then
      source "$1"
      ECHOCAT "$1 successfully sourced ... "
  else
      FAIL "$1 not sourced ... "
  fi
}

EXPORT_DIR() {
  if [ -d $1 ]; then
    export PATH=$1:$PATH
    ECHOCAT "$1 successfully exported ... "
  else
    FAIL "$1 not exported ... "
  fi
}

for cmd in "dnf" "apt"; do
  if  command -v $cmd >/dev/null; then
    case "$cmd" in
      "dnf")
        package_manager_install() {
          sudo dnf install -y "$@"
        }
        package_manager_remove() {
          sudo dnf autoremove -y "$@"
        }
        ;;
      "apt")
        package_manager_install() {
          sudo apt-get install -y "$@"
        }
        package_manager_remove() {
          sudo apt autoremove -y "$@"
        }
        ;;
    esac
    break
  fi
done
