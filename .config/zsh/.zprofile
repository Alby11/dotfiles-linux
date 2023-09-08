#!/bin/zsh
#
# .zprofile - Zsh file loaded on login.
#

echo # .zprofile - Zsh file loaded on login.
#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

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
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export PAGER="${PAGER:$(which nvim) -c 'Man!' -o -}"
export MANPAGER="${MANPAGER:$(which nvim) -c 'Man!' -o -}"
fi
#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  $HOME/{cargo,local}/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)
