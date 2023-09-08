#!/bin/zsh
#
# .zprofile - Zsh file loaded on login.
#

echocat '.zprofile - Zsh file loaded on login.'

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

