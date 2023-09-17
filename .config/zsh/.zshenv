#!/bin/env zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

# Uncomment to use the profiling module
zmodload zsh/zprof

# Some people insist on setting their PATH here to affect things like ssh.
# Those that do should probably use $SHLVL to ensure that this only happens
# the first time the shell is started (to avoid overriding a customized
# environment).  Also, the various profile/rc/login files all get sourced
# *after* this file, so they will override this value.  One solution is to
# put your path-setting code into a file named .zpath, and source it from
# both here (if we're not a login shell) and from the .zprofile file (which
# is only sourced if we are a login shell).
if [[ $SHLVL == 1 && ! -o LOGIN && -f $ZDOTDIR/.zpath ]]; then
  [[ -f $ZDOTDIR/.zpath ]] && source $ZDOTDIR/.zpath
fi

export THE_SHELL="$(echo $SHELL | grep -o '[^\/]*$')"

[[ -f $ZDOTDIR/.ztools.zsh ]] && source $ZDOTDIR/.ztools.zsh

# ECHOCAT ".zshenv - Zsh environment file, loaded always. SHLVL $SHLVL"

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
