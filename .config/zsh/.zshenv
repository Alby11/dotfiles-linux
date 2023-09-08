#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!


# use lolcat as a special echo command
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

echocat '.zshenv - Zsh environment file, loaded always.'

### SOURCING/EXPORTING UTILITIES
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


# fiexport XDG_CONFIG_HOME="$HOME/.config"
# Set ZDOTDIR if you want to re-home Zsh.
# export ZSH_CONFIG_HOME="$HOME/.config/zsh"
# export ZDOTDIR=$ZSH_CONFIG_HOME
# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
# Set omz variables prior to loading omz plugins
# see issue https://github.com/ohmyzsh/ohmyzsh/issues/11762
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
mkdir -p $ZSH_CACHE_DIR/completions

#
# Editors
#

export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"
export PAGER="${PAGER:-less}"
# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";
if command -v nvim &>/dev/null
then
  export EDITOR="${$(which nvim):-$EDITOR}"
  export VISUAL="${$(which nvim):-$VISUAL}"
  export PAGER="${$(which nvim):-$PAGER}"
  export MANPAGER="$(which nvim) -c 'Man!' -o -"
fi

if command -v batpipe &>/dev/null
then
  # To use batpipe, eval the output of this command in your shell init script.
  LESSOPEN="|$(which batpipe) %s";
  export LESSOPEN;
  unset LESSCLOSE;
  # The following will enable colors when using batpipe with less:
  # LESS="$LESS -R";
  BATPIPE="color";
  # export LESS;
  export BATPIPE;
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
  $HOME/{cargo,local}/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)
## You can use .zprofile to set environment vars for non-login, non-interactive shells.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
