#!/bin/zsh
# vim: set ft=zsh

# Function to check if internet is available
check_internet() {
  timeout 2 ping -c 1 8.8.8.8 &>/dev/null
  return $?
}

# Loop until internet connection is available
until check_internet; do
  sleep 5  # Wait for 5 seconds before checking again
done

# Use /tmp for temporary secrets file
SECRETS_FILE="$HOME/tmp/.zsecrets_env"
mkdir -p "$(dirname "$SECRETS_FILE")"

# Once internet is available, fetch and export secrets
for secret in $(aws secretsmanager list-secrets --output json | jq -r '.SecretList[] | @base64'); do
  _jq() {
    echo "${secret}" | base64 --decode | jq -r "${1}"
  }

  secret_value=$(aws secretsmanager get-secret-value --secret-id $(_jq '.Name') | jq -r ".SecretString")

  # Parse each key-value pair from the JSON in SecretString, add quotes around values
  echo "$secret_value" | \
    jq -r 'to_entries | .[] | "export \(.key)=\"\(.value)\""' >> "$SECRETS_FILE"
done

# Secure the secrets file
chmod 600 "$SECRETS_FILE"

source "$SECRETS_FILE"
rm -f "$SECRETS_FILE"
unset SECRETS_FILE
