#!/bin/sh
# vim: set ft=zsh

# Function to check if internet is available
check_internet() {
  timeout 2 ping -c 1 8.8.8.8 &>/dev/null
  return $?
}

# Loop until internet connection is available
until check_internet; do
  sleep 1 # Wait for 1 second before checking again
done

# Once internet is available, fetch and export secrets
for secret in $(aws secretsmanager list-secrets --output json | jq -r '.SecretList[] | @base64'); do
  _jq() {
    echo "${secret}" | base64 --decode | jq -r "${1}"
  }

  secret_value=$(aws secretsmanager get-secret-value --secret-id $(_jq '.Name') | jq -r ".SecretString")

  # Echo the export commands so they can be evaluated in the current shell
  echo "$secret_value" |
    jq -r 'to_entries | .[] | "export \(.key)=\(.value)"'
done
