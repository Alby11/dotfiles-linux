#!/bin/bash
#
# dotfiles -- Managing dotfiles for your $HOME
#
# The idea behind this approach is to treat your $HOME as a special git
# repository.
#
# Unlike a regular git repo, this one is always rooted at:
#   $HOME/.dotfiles_git
#
# Also unlike regular git, the approach here has you using the
# `dotfiles` alias/command.  This alias should be sourced into your
# shell. For example, when using bash, add the following to ~/.bashrc or
# powershell setup:
#
# ```bash
# function dotfiles {
#    git --git-dir=$HOME/.dotfiles_git/ --work-tree=$HOME $@
# }
# ```
#
# ```powershell
# # Setup alias for dotfiles, mimicking what is done in bash.
# function Invoke-Dotfiles () {
#   Invoke-Expression "git --git-dir=$HOME/.dotfiles_git --work-tree=$HOME/ $args"
# }
# Set-Alias dotfiles Invoke-Dotfiles
# ```
#
# The recommended way to use this script is to update the <GITREPO> line
# below, pointing it at *your* repo.  Once done, you should be able to
# run this script in any homedir you own to first install (and later
# refresh) your repo-based dotfiles.
#
# To manage your saved dotfiles use git commands, replacing git
# for the "dotfiles" alias above.
#
# Don't forget to add this script to your dotfiles repo:
#
# ```
# $ dotfiles add .setup_dotfiles.sh
# $ dotfiles commit
# ```
# 
# This script idea came from online, more specifically, this was
# initially lifted from:
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
#
# = Example usage
#
# ```
# $ dotfiles diff
# $ dotfiles add .bashrc
# $ dotfiles add .toprc
# $ dotfiles commit -m "Add bashrc and toprc files to my dotfiles repo."
# $ dotfiles push
#
# $ dotfiles fetch
# $ dotfiles rebase FETCH_HEAD
# $ dotfiles push
# ```

GITREPO="git@github.com:Alby11/dotfiles-linux.git"
cd $HOME
if [ ! -d $HOME/.dotfiles_git ] ; then
  # EDIT THE FOLLOWING LINE BY REPLACING GITREPO WITH WHERE
  # YOU STORE YOUR DOTFILES REPO!!
  git clone --bare $GITREPO $HOME/.dotfiles_git
fi
function dotfiles {
   git --git-dir=$HOME/.dotfiles_git/ --work-tree=$HOME $@
}
dotfiles config status.showUntrackedFiles no
dotfiles config --local branch.master.remote origin
dotfiles config --local branch.master.merge refs/heads/master

# Checkout/pull once, backup and try again if that doesn't work.
dotfiles checkout && dotfiles pull 2> /dev/null
if [ $? = 0 ]; then
    echo "Checked out dotfiles."
  else
    echo "Backing up pre-existing dot files."
    mkdir -p .dotfiles-backup
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | while read fn ; do
      mkdir -p .dotfiles-backup/$(dirname $fn)
      mv $fn .dotfiles-backup/$fn
    done
    dotfiles pull 2>&1 | egrep "\s+\." | awk {'print $1'} | while read fn ; do
      mkdir -p .dotfiles-backup/$(dirname $fn)
      mv $fn .dotfiles-backup/$fn
    done
    dotfiles checkout
    rmd -rf .dotfiles-backup
fi

# Enable submodules
echo "Refreshing submodules."
dotfiles submodule init
dotfiles submodule update
