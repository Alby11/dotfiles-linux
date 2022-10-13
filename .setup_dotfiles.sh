#!/bin/sh
: '
convenience functions for setting up or restoring dotfiles bare repo
to call them, create a Gist and use something like:
---
$gistURL="https://gist.github.com/Alby11/1843ee8b77631dbd550ab79675fbc27f"
OUT="$(mktemp)"; wget -q -O - $gistURL > $OUT; . $OUT
dotfilesRestore [dotfiles repo]
---
Credits to: Jonathan Bowman
https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3
'

dotDir="$HOME/.dotfiles_git/"
dotBranch="main"

dotfiles () {
  git --git-dir="$dotDir" --work-tree="$HOME" "$@"
}

dotfilesNew () {
  git clone --bare $1 $dotDir
  dotfiles config --local status.showUntrackedFiles no
  dotfiles switch -c $dotBranch

  echo "Please add and commit additional files"
  echo "using 'dotfiles add' and 'dotfiles commit', then run"
  echo "dotfiles push -u origin dotBranch"
}

dotfilesRestore () {
  git clone -b $dotBranch --bare $1 $dotDir
  dotfiles config --local status.showUntrackedFiles no
  dotfiles checkout || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ndotfiles checkout'
}
