# Start ssh-agent and load keys
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_*
fi

# Define pyenv root directory
export PYENV_ROOT="${HOME}/.pyenv"

# Update PATH and initialize pyenv
if [[ -d ${PYENV_ROOT}/bin ]]; then
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

# Atuin
. "$HOME/.atuin/bin/env"
