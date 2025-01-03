# vim: ft=zsh
# 
# NOTE: Revised .zshrc
#

# Start debug logging if ZSH_DEBUG is set
ZSH_DEBUG_LOG_STARTFILE "${(%):-%N}"

# Set catppuccin flavours variables
source "$ZDOTDIR/.zcolors_catppuccin"

# LS and Eza colors
if command -v vivid > /dev/null 2>&1; then
    export LS_COLORS="$(vivid generate catppuccin-mocha)"
else
    echo "vivid not found, using default LS_COLORS"
fi

# Enable Starship prompt
if [[ -f $XDG_CONFIG_HOME/starship/starship.toml ]] && command -v starship > /dev/null 2>&1; then
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
    eval "$(starship init zsh)"
fi

# Set options for better shell experience
export COMPLETION_WAITING_DOTS="true"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="%d/%m/%y %T"
export HISTFILE="$HOME/.local/share/zsh_history/.zsh_history"
export SAVEHIST=100000 # Number of history entries to save
export HISTSIZE=100000 # Number of commands to remember in history
export HISTFILESIZE=$HISTSIZE
mkdir -p "$(dirname $HISTFILE)"

# Enable various Zsh options
setopt EXTENDED_HISTORY
setopt auto_cd                    # Change to directory without 'cd'
setopt autocd                     # Automatically change to a directory when you type its name
setopt correct                    # Correct minor typos in directory names
setopt extendedglob               # Enable extended pattern matching
setopt histignorealldups          # Remove duplicate entries from history
setopt inc_append_history
setopt nonomatch                  # Avoid errors when no file matches a pattern
setopt sharehistory               # Share command history across multiple sessions

# Load all Zsh modules
for module in $(zmodload -L | awk '{print $2}'); do
    zmodload $module
done

# Shell setup for fnm NodeJS Manager
if ! command -v fnm > /dev/null 2>&1; then
    cargo install fnm
fi
eval "$(fnm env --use-on-cd)"
if ! command -v node > /dev/null 2>&1; then
    fnm install --lts
fi

# Set EDITOR
[[ -f $ZDOTDIR/.zeditor ]] && source "$ZDOTDIR/.zeditor"

# Set Zsh as VSCode default shell for the integrated terminal
if [[ "$TERM_PROGRAM" = "vscode" ]]; then
    vscode_shell_integration_path=$(code --locate-shell-integration-path zsh)
    if [[ -f "$vscode_shell_integration_path" ]]; then
        source "$vscode_shell_integration_path"
    fi
fi

# Atuin setup
[[ -f $HOME/.atuin/bin/env ]] && source "$HOME/.atuin/bin/env"
if command -v atuin > /dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi

# Antidote setup for managing plugins
source "$ZDOTDIR/.zantidote"

# Github CLI Copilot support
eval "$(gh copilot alias -- zsh)"

# Navi widget for Zsh
eval "$(navi widget zsh)"

# Contour terminal Zsh shell integration
source $XDG_CONFIG_HOME/contour/zcontour

# Set GTK theme
export GTK_THEME='catppuccin-mocha-green-standard+default'

# Load custom configurations
source "$ZDOTDIR/.zaliases"

### EMACS bindings
## default key bindings
source "$ZDOTDIR/.zemacs"
## Unbind C-'HJKL' and 'backward-kill-word' to use with tmux+nvim
# for key in '^H\' '^[^H\' '^[^?' '^H' '^J' '^K' '^L'; do
#     bindkey "$key" undefined-key
# done

# End debug logging if ZSH_DEBUG is set
ZSH_DEBUG_LOG_ENDFILE "Dotfiles processing complete:\n${(%):-%N}"
