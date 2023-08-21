#!/usr/bin/env zsh
#!/usr/bin/env bash
# exports

### GIT
git config --global core.autocrlf false
git config --global credential.helper manager-core
git config --global core.editor nvim
git config --global core.editor.nvim.path "/usr/bin/nvim"
git config --global diff.tool nvim
git config --global diff.tool.nvim.path "/usr/bin/nvim"
git config --global diff.tool.nvim.cmd "nvim -d \"$local\" \"$remote\""
git config --global core.pager 'nvim -'
git config --global init.default.branch main
git config --global core.fsmonitor false

### set up environment, depending on os
if find /dev -iname '*vmware*' &> /dev/null
then
    echo "Linux on VMware"
elif grep -qi microsoft /proc/version
then
    echo "Linux on wsl"
fi

if [ -e /etc/fedora-release ] ; then
    family='u'
else
    family='r'
fi

# Make neovim the default editor.
export VISUAL='nvim'
export EDITOR='nvim'
# Make most the default pager if present, if not use more
export PAGER='more'
if command -v most &>/dev/null
then
  export PAGER='most'
fi
#export LESS='-M'
# set CLICOLOR
export CLICOLOR=1

# export TERM color variable for Neovim inside Tmux
export TERM="xterm-256color"

# source OH-MY-ZSH main script 
SOURCE_RCFILE $ZSH/oh-my-zsh.sh

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

### SET MANPAGER
### Uncomment only one of these!

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set ZSH as VSCode default shell for the integrated terminal
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
### GITHUB repos exports
[ -d ~/gitdepot ] && gitdepot=~/gitdepot

# TTY theme
SOURCE_RCFILE $ZSH_CONFIG_HOME/catppuccin_tty/src/mocha.sh
# SOURCE_RCFILE $gitdepot/dracula_tty/dracula-tty.sh

# user-s bin path
EXPORT_DIR $HOME/.local/bin

### export CARGO
EXPORT_DIR $HOME/.cargo/bin

# bat extras scripts
# EXPORT_DIR $HOME/gitdepot/bat-extras/src
# batpipe, a bat-based preprocessor for less and bat.
# Version: 2022.07.27
# Homepage: https://github.com/eth-p/bat-extras
# Copyright (C) 2019-2021 eth-p | MIT License
# 
# To use batpipe, eval the output of this command in your shell init script.
LESSOPEN="|/usr/bin/batpipe %s";
export LESSOPEN;
unset LESSCLOSE;

# The following will enable colors when using batpipe with less:
LESS="$LESS -R";
BATPIPE="color";
export LESS;
export BATPIPE;

# KUBECONFIG
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config:$HOME/.kube/configs/kubeconfig.yaml

# if present, source FZF
[ -f ~/.fzf.zsh ] && SOURCE_RCFILE ~/.fzf.zsh

### Initialize Zoxide
if command -v zoxide &> /dev/null
then
    eval "$(zoxide init zsh)"
fi

### Initialize Starship
if command -v starship &>/dev/null
then
    eval "$(starship init zsh)"
fi

# GWSL
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
# export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
# export LIBGL_ALWAYS_INDIRECT=1 #GWSL
# export GDK_SCALE=2 #GWSL
# export QT_SCALE_FACTOR=2 #GWSL

# export DISPLAY
#DISPLAY=:1
