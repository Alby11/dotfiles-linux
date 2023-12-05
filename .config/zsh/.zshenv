#!/bin/env zsh
#
# .zshenv
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

echo """
.zshenv - Zsh envfile, loaded always, as first. SHLVL $SHLVL

""" | lolcat

# Uncomment to use the profiling module
zmodload zsh/zprof

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

[[ -f $ZDOTDIR/.ztools.zsh ]] && source $ZDOTDIR/.ztools.zsh

if [[ $0 == /* ]]; then
    ECHOCAT "This is a login shell"
else
    ECHOCAT "This is not a login shell"
fi

export THE_SHELL="$(echo $SHELL | grep -o '[^\/]*$')"
