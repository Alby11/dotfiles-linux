# vim: filetype=zsh
#
# .zshrc
#

ECHOCAT """
.zshrc - Zsh file loaded on login/non-login shell sessions.
login: after .zprofile and before .zlogin
non-login: after .zshenv
"""

# Zsh options.
setopt extendedglob
export HISTORY_BASE="${ZDOTDIR:-$HOME}/.directory_history"
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HIST_STAMPS="yyyy-mm-dd"
setopt EXTENDED_HISTORY
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"

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

# Export GOPATH
[[ -d ${HOME}/go ]] && export GOPATH=${HOME}/go

# Export JAVA_HOME from default alternative
if ! javac_path=$(readlink -f "$(which javac)"); then
	echo "Failed to locate javac"
	exit 1
fi
JAVA_HOME=$(dirname "$(dirname "$javac_path")")
export JAVA_HOME

# Shell setup for fnm NodeJS Manager
if CHECK_COMMANDS "fnm"; then
	if ! CHECK_COMMANDS "node"; then
		fnm install --lts
	fi
	eval "$(fnm env --use-on-cd)"
fi

# Antidote ZSH plugin manager
SOURCE_RCFILE "${ZDOTDIR}"/.zantidote

# set Ls_COLORS if vivid is installed
if ! CHECK_COMMANDS "vivid"; then
	cargo install vivid
fi
export LS_COLORS
LS_COLORS="$(vivid generate catppuccin-mocha)"

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'

# set ZSH as VSCode default shell for the integrated terminal
# shellcheck disable=SC1090
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
	vscode_shell_integration_path=$(code --locate-shell-integration-path zsh)
	if [[ -f "$vscode_shell_integration_path" ]]; then
		source "$vscode_shell_integration_path"
	fi
fi

# source SSH settings, including agent config
SOURCE_RCFILE "${ZDOTDIR}/.zssh"

### Initialize Starship
if ! CHECK_COMMANDS starship; then
	curl -sSv 'https://starship.rs/install.sh' | sh
fi
if [[ $(whoami) == 'root' ]]; then
	export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/root_starship.toml"
else
	export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/user_starship.toml"
fi
eval "$(starship init "${THE_SHELL}")"
