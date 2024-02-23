# vim: filetype=zsh
#
# .zshrc
#

ECHOCAT """
.zshrc - Zsh file loaded on login/non-login shell sessions.
login: after .zprofile and before .zlogin
non-login: after .zshenv
"""

# export TERM color variable
export TERM="xterm-256color"

# Zsh options.
setopt extended_glob
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HIST_STAMPS="yyyy-mm-dd"
setopt EXTENDED_HISTORY
export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"
export COLORTERM=truecolor


# Antidote ZSH plugin manager
SOURCE_RCFILE ${ZDOTDIR}/.zantidote


# set Ls_COLORS if vivid is installed
if ! CHECK_COMMANDS "vivid"; then
  cargo install vivid
fi
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Export GOPATH
[[ -d ${HOME}/go ]] && export GOPATH=${HOME}/go

# Export JAVA_HOME from default alternative
if CHECK_COMMANDS javac; then
  export JAVA_HOME="$(dirname $(dirname $(readlink $(readlink $(which javac)))))"
fi

# Shell setup for fnm NodeJS Manager
if CHECK_COMMANDS "fnm"; then
  if ! CHECK_COMMANDS "node"; then
    fnm install --lts
  fi
  eval "$(fnm env --use-on-cd)"
fi

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set ZSH as VSCode default shell for the integrated terminal
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

### Initialize Starship
if ! CHECK_COMMANDS starship; then
  curl -sSv 'https://starship.rs/install.sh' | sh
fi
if [[ $(whoami) == 'root' ]]; then
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/root_starship.toml"
else
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/user_starship.toml"
fi
eval "$(starship init ${THE_SHELL})"

