#!/usr/bin/fish
# config.fish

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
if find /dev -iname '*vmware*' > /dev/null
    echo "Linux on VMware"
else if grep -qi microsoft /proc/version
    echo "Linux on wsl"
end

if test -e /etc/fedora-release
    set family 'u'
else
    set family 'r'
end

# Make neovim the default editor.
set -x VISUAL 'nvim'
set -x EDITOR 'nvim'
# Make most the default pager if present, if not use more
set -x PAGER 'less'
set -x LESS '-M -R'

# set CLICOLOR
set -x CLICOLOR 1

# export TERM color variable for Neovim inside Tmux
set -x TERM "xterm-256color"

# export COLORTERM to make most detect 24 bit truecolor
set COLORTERM truecolor

# source OH-MY-ZSH main script 
# source $ZSH/oh-my-zsh.sh

# Enable persistent REPL history for `node`.
set -x NODE_REPL_HISTORY ~/.node_history;
# Allow 32³ entries; the default is 1000.
set -x NODE_REPL_HISTORY_SIZE '32768';
# Use sloppy mode by default, matching web browsers.
set -x NODE_REPL_MODE 'sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
set -x PYTHONIOENCODING 'UTF-8';

# Omit duplicates and commands that begin with a space from history.
set HISTCONTROL 'ignoreboth';

# Prefer US English and use UTF-8.
set -x LANG 'en_US.UTF-8';
set -x LC_ALL 'en_US.UTF-8';

# Highlight section titles in manual pages.
set LESS_TERMCAP_md "$yellow";

### SET MANPAGER
### Uncomment only one of these!

### "bat" as manpager
# set MANPAGER "sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# set MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
# set MANPAGER "nvim -c 'set ft=man' -"

# colored GCC warnings and errors
set GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set ZSH as VSCode default shell for the integrated terminal
if test "$TERM_PROGRAM" = "vscode"
    source (code --locate-shell-integration-path fish | psub)
end

### GITHUB repos exports
if test -d ~/gitdepot; set gitdepot ~/gitdepot; end

# TTY theme
# source $ZSH_CONFIG_HOME/catppuccin_tty/src/mocha.sh

# user-s bin path
EXPORT_DIR $HOME/.local/bin

### export CARGO
EXPORT_DIR $HOME/.cargo/bin

# bat extras scripts
set LESSOPEN "|/usr/bin/batpipe %s"
set LESSOPEN;
unset LESSCLOSE;

set BATPIPE="color";
set BATPIPE;

# KUBECONFIG
set KUBECONFIG $KUBECONFIG:$HOME/.kube/config:$HOME/.kube/configs/kubeconfig.yaml

# if present, source FZF
if test -f ~/.fzf.fish
  source ~/.fzf.fish
end

# Initialize Starship
if command -v starship > /dev/null
    starship init fish | source
end

# Initialize Zoxide
if command -v zoxide > /dev/null
    zoxide init fish | source
end
