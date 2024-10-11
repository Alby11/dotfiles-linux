# vim: ft=bash

# Fetch secrets
# Fetch secrets
# Check if the script exists and is executable
if [[ -x ${HOME}/.config/zsh/.fetch_secrets.sh ]]; then
  # Run the script and evaluate each line in the current shell
  while IFS= read -r line; do
    if echo "$line" | grep -q 'BW_SESSION='; then
      line=$(echo "$line" | sed 's/BW_SESSION=//')
    fi
    eval "$line"
  done < <(${HOME}/.config/zsh/.fetch_secrets.sh)
fi

# Atuin
. "$HOME/.atuin/bin/env"
