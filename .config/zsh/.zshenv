#!/bin/env zsh
#
# .zshenv
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!


if command -v lolcat > /dev/null 2>&1; then
  echo """
  .zshenv - Zsh envfile, loaded always, as first. SHLVL $SHLVL
  """ | lolcat
else
  echo """
  .zshenv - Zsh envfile, loaded always, as first. SHLVL $SHLVL
  """
fi

# Uncomment to use the profiling module
zmodload zsh/zprof

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

[[ -f $ZDOTDIR/.ztools ]] && source $ZDOTDIR/.ztools

if [[ $0 == /* ]]; then
    ECHOCAT "This is a login shell"
else
    ECHOCAT "This is not a login shell"
fi

export THE_SHELL="$(echo $SHELL | grep -o '[^\/]*$')"
