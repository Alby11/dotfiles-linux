#!/bin/bash

# List of pip-installed tools to migrate
packages=$(pip list --format=freeze | cut -d= -f1)

for package in $packages; do
  echo "Installing $package via pipx..."
  pipx install "$package" && pip uninstall -y "$package"
done
