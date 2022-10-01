#!/bin/zsh
curDir=$(pwd)
cd $HOME
function dotfiles {
   git --git-dir=$HOME/.dotfiles_git/ --work-tree=$HOME $@
}
# dotfiles add .bash* .zsh* bootstrap.sh .setup_dotfiles.sh .oh-my-zsh* .tmux.conf .config/bat .config/btop .config/ranger catppuccin_tty zsh-syntax-highlighting .dotfiles_sync.sh -v
dotfiles add -u -v
dotfiles commit -m "Edited on: $(date)" -v
dotfiles push -v
source .zshrc
cd $curDir
