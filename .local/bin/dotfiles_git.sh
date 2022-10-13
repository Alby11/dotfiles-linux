#!/bin/zsh

curDir=$(pwd)
local function dotfiles {
   git --git-dir=$HOME/.dotfiles_git/ --work-tree=$HOME $@
}

local function dofilesStatus () {
  dotfiles status
}

local function dotfilesAdd ()
{
  dotfiles add -u 
}

local function dotfilesCommit ()
{
  dotfiles commit -m "$(date)"
}

local function dotfilesPush ()
{
  dotfiles push -v
}

local function cdHomeAndBack ()
{
  cd $HOME
  cd $curDir
}
