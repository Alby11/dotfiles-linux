# Revised .zshenv
# vim: ft=zsh
# 
# NOTE: Revised .zshenv
# 

# Ensure a user-defined ZDOTDIR or default to HOME
export XDG_CONFIG_HOME=${HOME}/.config
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
mkdir -p ${ZDOTDIR}

# Profile debug system
export ZSH_DEBUG=1
if [ "$ZSH_DEBUG" -eq 1 ]; then
    echo "\n\n++++++++++++++++++++++++++++++++++++" > ${ZDOTDIR}/.zsh_debug.log
    echo "$SHELL dotfiles setup starts here...\n" >> ${ZDOTDIR}/.zsh_debug.log
else
    rm -fv ${ZDOTDIR}/.zsh_debug.log
fi

ZSH_DEBUG_LOG_STARTFILE() {
    if [ "$ZSH_DEBUG" -eq 1 ]; then
    echo "\n\n------------------------------------" >> ${ZDOTDIR}/.zsh_debug.log
        # Add a timestamp
        date +"%Y-%m-%d %H:%M:%S" >> ${ZDOTDIR}/.zsh_debug.log
        # Log that the file has been sourced
        echo "$1 is being sourced" >> ${ZDOTDIR}/.zsh_debug.log
    fi
}

ZSH_DEBUG_LOG_ENDFILE() {
    if [ "$ZSH_DEBUG" -eq 1 ]; then
        # Add a timestamp
        date +"%Y-%m-%d %H:%M:%S" >> ${ZDOTDIR}/.zsh_debug.log
        # Log that the file has been sourced
        echo "$1 has been sourced" >> ${ZDOTDIR}/.zsh_debug.log
    echo "\n\n------------------------------------" >> ${ZDOTDIR}/.zsh_debug.log
    fi
}

ZSH_DEBUG_LOG_STARTFILE "${(%):-%N}"

# Autostart tmux if conditions are met
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    $HOME/.local/bin/tmux_chooser.zsh
fi

# Language and locale settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# export TERM color variable
export TERM="xterm-256color"
# export COLORTERM
export COLORTERM="truecolor"
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# determine distro for later use
if [[ -f /etc/fedora-release ]]; then
    export DISTRO="fedora"
elif [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ $NAME == "Ubuntu" ]]; then
        export DISTRO="ubuntu"
    elif [[ $ID == "arch" || $ID_LIKE == "arch" ]]; then
        export DISTRO="arch"
    fi
fi

# Include custom tools
[[ -f "${ZDOTDIR}/.ztools" ]] && source "${ZDOTDIR}/.ztools"

# Include custom path management
[[ -f "${ZDOTDIR}/.zpath" ]] && source "${ZDOTDIR}/.zpath"

# Fetch secrets
# Check if the script exists and is executable
if [[ -x $ZDOTDIR/.fetch_secrets.sh ]]; then
  # Run the script and evaluate each line in the current shell
  while IFS= read -r line; do
      if echo "$line" | grep -q 'BW_SESSION='; then
          line=$(echo "$line" | sed 's/BW_SESSION=//')
      fi
      eval "$line"
  done < <($ZDOTDIR/.fetch_secrets.sh)
fi

# Python environment management
[[ -f "${ZDOTDIR}/.zpyenv" ]] && source "${ZDOTDIR}/.zpyenv"

# Export GOPATH
[[ -d "${HOME}/go" ]] && export GOPATH="${HOME}/go"

# Export JAVA_HOME from default alternative
if ! javac_path=$(readlink -f "$(which javac)"); then
    echo "Failed to locate javac"
fi
export JAVA_HOME="$(dirname $(dirname $javac_path))"

# Export environment variables for FZF and any other tools
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude '.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="\
    --height=100% \
    --reverse \
    --border=sharp \
    --color=bg+:#313244,gutter:-1,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --multi" # catppuccin colors

# set theme variables, for flatpak, etc.
export GTK_THEME=catppuccin-mocha-green-standard+default
export ICON_THEME=Catppuccin-Mocha-Green-Cursors

# For security, prevent core dumps
ulimit -c 0

ZSH_DEBUG_LOG_ENDFILE "${(%):-%N}"
