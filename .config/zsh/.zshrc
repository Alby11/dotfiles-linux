# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# vim: filetype=zsh
#
# NOTE: .zshrc
#

ECHOCAT """
.zshrc - Zsh file loaded on login/non-login shell sessions.
login: after .zprofile and before .zlogin
non-login: after .zshenv
"""

# Load variables from .env
set -o allexport
source ${ZDOTDIR}/.env >/dev/null 2>&1
set +o allexport

# Zsh options.
setopt extendedglob
export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"
export HISTFILE="$HOME/.local/share/zsh_history/.zsh_history"
mkdir -p "$(dirname $HISTFILE)"
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HIST_STAMPS="%d/%m/%y %T"
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt inc_append_history
setopt share_history

# Fetch secrets
[[ -x ${ZDOTDIR}/.fetch_secrets.sh ]] && eval $(${ZDOTDIR}/.fetch_secrets.sh)
#export BW_SESSION=$(bw-read-session) export BW_SESSION=$(bw-read-session)

# source colors scripts
SOURCE_RCFILE "${ZDOTDIR}/.zcolors_catppuccin"

# export TERM color variable
export TERM="xterm-256color"
# export COLORTERM
export COLORTERM="truecolor"
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set up GPG agent
GPG_TTY=$(tty)
export GPG_TTY

# Shell setup for fnm NodeJS Manager
if ! CHECK_COMMANDS "fnm"; then
	cargo install fnm
fi
eval "$(fnm env --use-on-cd)"
if ! CHECK_COMMANDS "node"; then
	fnm install --lts
fi

# Antidote ZSH plugin manager
SOURCE_RCFILE "${ZDOTDIR}"/.zantidote

# Export GOPATH
[[ -d ${HOME}/go ]] && export GOPATH=${HOME}/go

# Export JAVA_HOME from default alternative
if ! javac_path=$(readlink -f "$(which javac)"); then
	echo "Failed to locate javac"
fi
JAVA_HOME=$(dirname "$(dirname "$javac_path")")
export JAVA_HOME

# set Ls_COLORS if vivid is installed
if ! CHECK_COMMANDS "vivid"; then
	cargo install vivid
fi
export {EZA,LS}_COLORS="$(vivid generate catppuccin-mocha)"

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

# source SSH settings, including agent config
# SOURCE_RCFILE "${ZDOTDIR}/.zssh"

# set up Ansible config root
export ANSIBLE_HOME=${XDG_CONFIG_HOME}/ansible

# SOURCE_RCFILE "${ZDOTDIR}/.zcompletions"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ -f ${ZDOTDIR}/.p10k.zsh ]] && source ${ZDOTDIR}/.p10k.zsh

# Load completions
autoload -Uz compinit && compinit

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG "${(%):-%N}"
