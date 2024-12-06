export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
# Source the Lazyman shell initialization for aliases and nvims selector
# shellcheck source=.config/nvim-Lazyman/.lazymanrc
[ -f ~/.config/nvim-Lazyman/.lazymanrc ] && source ~/.config/nvim-Lazyman/.lazymanrc
# Source the Lazyman .nvimsbind for nvims key binding
# shellcheck source=.config/nvim-Lazyman/.nvimsbind
[ -f ~/.config/nvim-Lazyman/.nvimsbind ] && source ~/.config/nvim-Lazyman/.nvimsbind
# Luarocks bin path
[ -d ${HOME}/.luarocks/bin ] && {
	export PATH="${HOME}/.luarocks/bin${PATH:+:${PATH}}"
}

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# Define pyenv root directory
export PYENV_ROOT="${HOME}/.pyenv"

# Update PATH and initialize pyenv
if [[ -d ${PYENV_ROOT}/bin ]]; then
	export PATH="${PYENV_ROOT}/bin:${PATH}"
	eval "$(pyenv init --path)"
	eval "$(pyenv virtualenv-init -)"
fi

# Atuin
eval "$(atuin init bash)"
