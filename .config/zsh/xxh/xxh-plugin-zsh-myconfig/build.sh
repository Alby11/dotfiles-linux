#!/usr/bin/env bash
# build.sh

# Set the ZDOTDIR environment variable
echo 'export ZDOTDIR=$HOME/.xxh/.config/zsh' > $PXXH_HOME/.zshenv

# Copy the zsh configuration files to the plugin directory
mkdir -p $PXXH_HOME/.xxh/.config/zsh
cp -r ~/.config/zsh/* $PXXH_HOME/.xxh/.config/zsh/
