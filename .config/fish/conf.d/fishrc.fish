#!/usr/bin/env fish
# config.fish

### SOURCING/EXPORTING UTILITIES
function SOURCE_RCFILE
    if test -f $argv[1]
        source $argv[1]
        echo "$argv[1] successfully sourced ... "
        return
    end
    echo "$argv[1] not sourced ... "
end

function EXPORT_DIR
    if test -d $argv[1]
        set PATH $argv[1] $PATH
        echo "$argv[1] successfully exported ... "
        return
    end
    echo "$argv[1] not exported ... "
end

# export fish config directory
# set -x FISH_CONFIG_HOME "$HOME/.config/fish"
# set -x FISH_CUSTOM $FISH_CONFIG_HOME/custom

### ANTIDOTE

# Exports
SOURCE_RCFILE $FISH_CONFIG_HOME/exports.fish

# Aliases
SOURCE_RCFILE $FISH_CONFIG_HOME/aliases.fish

# Functions
SOURCE_RCFILE $FISH_CONFIG_HOME/functions.fish

# load ssh after each reboot (re-uses same ssh-agent instance)
if not command -v keychain > /dev/null
    sudo dnf install -y keychain > /dev/null ^&1
    sudo rpm install -y keychain > /dev/null ^&1
    sudo apt install -y keychain > /dev/null ^&1
end

set SSH_ENV "$HOME/.ssh/agent-environment"

function start_agent
    echo "Initialising new SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' > $SSH_ENV
    echo succeeded
    chmod 600 $SSH_ENV
    source $SSH_ENV > /dev/null

    for file in ~/.ssh/id_*
        if ls $file | grep pub > /dev/null; continue; end
        eval (keychain --eval $file)
    end
end

# Source SSH settings, if applicable
if test -f $SSH_ENV
    source $SSH_ENV > /dev/null

    if not pgrep -f "ssh-agent" > /dev/null; start_agent; end
else
    start_agent;
end

# Welcome message
if command -v neofetch > /dev/null; neofetch; end

if command -v fortune > /dev/null; and command -v cowsay > /dev/null; fortune | cowsay; end

cd ~
