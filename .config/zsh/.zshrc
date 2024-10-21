
# Revised .zshrc
# vim: ft=zsh
# 
# NOTE: Revised .zshrc
#

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG_STARTFILE "${(%):-%N}"

# set catppuccin flavours variables
source "$ZDOTDIR/.zcolors_catppuccin"

# PROMPT
# Enable Powerlevel10k instant prompt
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# [[ -f ${ZDOTDIR}/.p10k.zsh ]] && source ${ZDOTDIR}/.p10k.zsh
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml; eval $(starship init zsh)

# Set options for better shell experience
export COMPLETION_WAITING_DOTS="true"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="%d/%m/%y %T"
export HISTFILE="$HOME/.local/share/zsh_history/.zsh_history"
export SAVEHIST=100000 # Number of history entries to save
export HISTSIZE=100000 # Number of commands to remember in history
export HISTFILESIZE=$HISTSIZE
mkdir -p "$(dirname $HISTFILE)"

setopt EXTENDED_HISTORY
setopt auto_cd                    # Change to directory without 'cd'
setopt autocd                      # Automatically change to a directory when you type its name
setopt correct                    # Correct minor typos in directory names
setopt extendedglob               # Enable extended pattern matching
setopt histignorealldups          # Remove duplicate entries from history
setopt inc_append_history
setopt nonomatch                  # Avoid errors when no file matches a pattern
setopt sharehistory               # Share command history across multiple sessions

# Shell setup for fnm NodeJS Manager
if ! command -v fnm > /dev/null 2>&1; then
    cargo install fnm
fi
eval "$(fnm env --use-on-cd)"
if ! command -v node > /dev/null 2>&1; then
    fnm install --lts
fi

# set EDITOR
source "$ZDOTDIR/.zeditor"

# set ZSH as VSCode default shell for the integrated terminal
if [[ "$TERM_PROGRAM" = "vscode" ]]; then
    vscode_shell_integration_path=$(code --locate-shell-integration-path zsh)
    if [[ -f "$vscode_shell_integration_path" ]]; then
        source "$vscode_shell_integration_path"
    fi
fi

# Atuin
source "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Python environment management (moved from .zshenv)
if [[ -f "${ZDOTDIR}/.zpyenv" ]]; then
    source "${ZDOTDIR}/.zpyenv"
fi

# Antidote setup for managing plugins
source "$ZDOTDIR/.zantidote"
source "$ZDOTDIR/.zsh_plugin_configurations.zsh"

# Github CLI Copilot support
eval "$(gh copilot alias -- zsh)"

# Load custom configurations
source "$ZDOTDIR/.zaliases"

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG_ENDFILE "${(%):-%N}"
