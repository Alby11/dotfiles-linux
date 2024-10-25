#!/bin/zsh
# vim: set ft=sh

# Function to check if internet is available
check_internet() {
  timeout 2 ping -c 1 8.8.8.8 &>/dev/null
  return $?
}

# Loop until internet connection is available
until check_internet; do
  sleep 1 # Wait for 1 second before checking again
done

# Once internet is available, fetch and output export commands
for secret in $(aws secretsmanager list-secrets --output json | jq -r '.SecretList[] | @base64'); do
  _jq() {
    echo "${secret}" | base64 --decode | jq -r "${1}"
  }

  secret_value=$(aws secretsmanager get-secret-value --secret-id $(_jq '.Name') | jq -r ".SecretString")

  # Output export commands for each secret
  echo "$secret_value" | jq -r 'to_entries | .[] | "export \(.key)=\(.value)"'
done
