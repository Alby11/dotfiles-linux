if command -v dotfiles
then
  dotfiles add .bash* .zsh* bootstrap.sh .setup_dotfiles.sh .oh-my-zsh* .tmux.conf .config/bat .config/btop .config/ranger catppuccin_tty zsh-syntax-highlighting .dotfiles_sync.sh -v
fi \
  && dotfiles commit -m "$(date)" -v \
  && dotfiles push -v && \
  source .zshrc
