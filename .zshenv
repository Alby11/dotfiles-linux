#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#
echo '.zshenv - Zsh environment file, loaded always.'

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

# fiexport XDG_CONFIG_HOME="$HOME/.config"
# Set ZDOTDIR if you want to re-home Zsh.
# export ZSH_CONFIG_HOME="$HOME/.config/zsh"
# export ZDOTDIR=$ZSH_CONFIG_HOME
# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Set omz variables prior to loading omz plugins
# see issue https://github.com/ohmyzsh/ohmyzsh/issues/11762
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
mkdir -p $ZSH_CACHE_DIR/completions

## You can use .zprofile to set environment vars for non-login, non-interactive shells.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
# [[ -v XXH_HOME ]] && source $ZDOTDIR/.zshrc
