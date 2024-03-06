#!/bin/env zsh
#
# .zshenv
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

if [ -z "$SSH_CONNECTION" ]; then
  if command -v lolcat > /dev/null 2>&1; then
    echo """
    .zshenv - Zsh envfile, loaded always, as first. SHLVL ( $SHLVL ) 
    """ | lolcat
  else
    echo """
    .zshenv - Zsh envfile, loaded always, as first. SHLVL ( $SHLVL )
    """
  fi
fi

# determine distro for later user
if [[ -f /etc/fedora-release ]]; then
  export DISTRO="fedora"
elif [[ -f /etc/os-release ]]; then
  . /etc/os-release
  if [[ $NAME == "Ubuntu" ]]; then
    export DISTRO="ubuntu"
  elif [[ $ID == "arch" || $ID_LIKE == "arch" ]]; then
    export DISTRO="arch"
  fi
fi

# Uncomment to use the profiling module
zmodload zsh/zprof

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

[[ -f ${ZDOTDIR}/.ztools ]] && source ${ZDOTDIR}/.ztools

if [ -z "$SSH_CONNECTION" ]; then
  echo "\n"
  if [[ IS_LOGIN_SHELL ]]; then
    ECHOCAT "This is a login shell"
  else
    ECHOCAT "This is not a login shell"
  fi
  echo "\n"
fi

export THE_SHELL="$(echo $SHELL | grep -o '[^\/]*$')"

# Some people insist on setting their PATH here to affect things like ssh.
# Those that do should probably use $SHLVL to ensure that this only happens
# the first time the shell is started (to avoid overriding a customized
# environment).  Also, the various profile/rc/login files all get sourced
# *after* this file, so they will override this value.  One solution is to
# put your path-setting code into a file named .zpath, and source it from
# both here (if we're not a login shell) and from the .zprofile file (which
# is only sourced if we are a login shell).
source $ZDOTDIR/.zpath
