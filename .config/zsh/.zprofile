#!/bin/env zsh
#
# .zprofile - Zsh file loaded on login.
#

ECHOCAT '.zprofile - Zsh file loaded on login.'

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

