# vim: filetype=zsh
#
# NOTE: .zshrc
#

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG_STARTFILE "${(%):-%N}"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ -f ${ZDOTDIR}/.p10k.zsh ]] && source ${ZDOTDIR}/.p10k.zsh
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

# Export GOPATH
[[ -d ${HOME}/go ]] && export GOPATH=${HOME}/go

# Export JAVA_HOME from default alternative
if ! javac_path=$(readlink -f "$(which javac)"); then
	echo "Failed to locate javac"
fi
export JAVA_HOME=$(dirname "$(dirname "$javac_path")")

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'

# set ZSH as VSCode default shell for the integrated terminal
# shellcheck disable=SC1090
if [[ "$TERM_PROGRAM" = "vscode" ]]; then
	vscode_shell_integration_path=$(code --locate-shell-integration-path zsh)
	if [[ -f "$vscode_shell_integration_path" ]]; then
		source "$vscode_shell_integration_path"
	fi
fi

# Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Antidote setup for managing plugins
source "$ZDOTDIR/.zantidote"
source "$ZDOTDIR/.zsh_plugin_configurations.zsh"

# Load custom configurations
source "$ZDOTDIR/.zaliases"
source "$ZDOTDIR/.zcolors_catppuccin"

# Load editor configurations
source "$ZDOTDIR/.zeditor"

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG_ENDFILE "${(%):-%N}"
