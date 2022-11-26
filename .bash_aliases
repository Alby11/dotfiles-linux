#!/bin/sh

alias sudo='sudo '

alias SC="source $HOME/.zshrc"

alias EEE='exit'
alias G='| grep -i '
alias L='| less +f'
alias dush='sudo du -sh'
alias grep='grep --color'
alias h="history -10" # last 10 history commands
alias hr="history | grep " # +command
alias nta='sudo netstat -poeta'
alias ola='/bin/ls -lahi'
alias ols='/bin/ls'
alias psa='sudo ps -aux'
alias C="clear"
alias dfh='df -h'
alias freeh='free -mh'

alias myip='curl http://ipecho.net/plain; echo'

if command -v ss &> /dev/null
then
  alias ssa='sudo ss -poeta'
fi

if command -v systemctl &> /dev/null
then
    alias sys='sudo systemctl'
    alias syt='sudo systemctl start'
    alias syp='sudo systemctl stop'
    alias syr='sudo systemctl restart'
    alias syu='sudo systemctl status'
fi

if command -v apt &> /dev/null
then
    alias apt='sudo apt'
    alias apts='sudo apt search'
    alias aptu='sudo apt update'
    alias aptup='sudo apt upgrade -y'
    alias aptdup='sudo apt dist-upgrade -y'
    alias apti='sudo apt install -y'
    alias aptr='sudo apt remove'
    alias aptar='sudo apt autoremove'
    alias aptap='sudo apt autopurge'
fi

if command -v tmux &> /dev/null
then
    alias T='tmux'
    alias tls='tmux ls'
    alias ta='tmux attach -t'
    alias tn='tmux new -s'
    alias tr='tmux rename-session -t'
    alias tk='tmux kill-session -t'
fi

if command -v nvim &> /dev/null ; then
  alias nvim='nvim -u ~/.config/nvim/init.lua'
  alias nv='nvim'
  alias vi='nvim'
  alias vim='nvim'
  alias N='| nvim'
  if command -v nvr &> /dev/null ; then
    alias nvimr='nvim --listen /tmp/nvimsocket'
    alias nvrs='nvr -s'
    # alias nvrr='nvr --remote'
    # alias nvrs='nvr --remote-send'
    # alias nvre='nvr --remote-expr'
    # alias nvrc='nvr -c'
  fi
fi

if command -v xclip &> /dev/null
then
    alias Xp='xclip -o'
    alias Xy=' | xclip -i'
fi
if command -v clipboard &> /dev/null
then
  alias Cp="clipboard"
  alias Cy=' | clipboard'
fi
if command -v wl-copy &> /dev/null
then
  alias Wp="wl-paste"
  alias Wy=' | wl-copy'
fi

if command -v ranger &> /dev/null
then
    alias rw='ranger'
fi

if command -v fdfind &> /dev/null
then
    alias fd='fdfind'
fi

if command -v cargo &>/dev/null ; then
  if command -v z &> /dev/null ; then
    alias cd='z'
  fi
fi

if command -v exa &> /dev/null
then
  alias ls="exa --icons --git --group-directories-first"
  alias ll="exa -l -g --icons --git --group-directories-first"
  alias la="exa -l -a --icons --git --group-directories-first"
  alias lt="exa -L 1 --icons --tree --git-ignore --group-directories-first"
fi

if command -v git &> /dev/null
then
  alias g='git'
  function dotfiles {
     git --git-dir=$HOME/.dotfiles_git/ --work-tree=$HOME $@
  }    
  alias dot='dotfiles'
fi

if command -v kubectl &> /dev/null
then
    source <(kubectl completion zsh)
    alias k='kubectl'
fi

if command -v minikube &> /dev/null
then
    source <(minikube completion zsh)
    alias mk='minikube'
fi

if command -v docker &> /dev/null
then
    alias dk='docker'
fi

if command -v ansible &> /dev/null
then
    alias an='ansible'
    alias ana='ansible all:'
fi

if command -v podman &> /dev/null
then
    alias pd='podman'
fi

if [ $( command -v fzf ) ] && [ $( command -v rg ) ] ; then
  export FZF_BASE=/usr/bin/fzf
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
  # catppucin theme
  # export FZF_DEFAULT_OPTS=' \
    # --preview "bat --color=always --style=numbers --line-range=:500 {}" \
    # --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    # --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    # --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"'
  # dracula theme
  export FZF_DEFAULT_OPTS='\
    bat --color=always --style=numbers --line-range=:500 {}" \
    --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
    --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
    --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
    --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
    DISABLE_FZF_AUTO_COMPLETION="false"
  DISABLE_FZF_KEY_BINDINGS="true"
  alias fzfb="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}"
  alias R='| rg'
else
  echo "fzf or rg are missing..."
fi
