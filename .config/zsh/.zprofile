#!/bin/env zsh
#
# .zprofile - Zsh file loaded on login.
#

ECHOCAT '.zprofile - Zsh file loaded on login, right after .zshenv.'

# Some people insist on setting their PATH here to affect things like ssh.
# Those that do should probably use $SHLVL to ensure that this only happens
# the first time the shell is started (to avoid overriding a customized
# environment).  Also, the various profile/rc/login files all get sourced
# *after* this file, so they will override this value.  One solution is to
# put your path-setting code into a file named .zpath, and source it from
# both here (if we're not a login shell) and from the .zprofile file (which
# is only sourced if we are a login shell).
# if [[ $SHLVL == 1 && ! -o LOGIN && -f $ZDOTDIR/.zpath ]]; then
if [[ $SHLVL == 1 && -f $ZDOTDIR/.zpath ]]; then
  source $ZDOTDIR/.zpath
fi

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

