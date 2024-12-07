# Optimized Version of .zprofile

ZSH_DEBUG_LOG_STARTFILE "${(%):-%N}"

# Define pyenv root directory
export PYENV_ROOT="${HOME}/.pyenv"

# Update PATH and initialize pyenv
if [[ -d ${PYENV_ROOT}/bin ]]; then
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

ZSH_DEBUG_LOG_ENDFILE "${(%):-%N}"
