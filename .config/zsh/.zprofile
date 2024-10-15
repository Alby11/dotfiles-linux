# Optimized Version of .zshprofile

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG_STARTFILE "${(%):-%N}"

#
# # Source .zshenv for base environment variables
# source "$ZDOTDIR/.zshenv"
#
# # Set the zsh options
# setopt hist_ignore_all_dups share_history inc_append_history
#
# # Load path management if present
# if [[ -f "$ZDOTDIR/.zpath" ]]; then
#   source "$ZDOTDIR/.zpath"
# fi
#
# # Configure plugins via Antidote
# if [[ -f "$ZDOTDIR/.zsh_plugins.txt" ]]; then
#   source <(antidote bundle < "$ZDOTDIR/.zsh_plugins.txt")
# fi
#
# # Include any additional plugin configurations
# if [[ -f "$ZDOTDIR/.zsh_plugin_configurations.zsh" ]]; then
#   source "$ZDOTDIR/.zsh_plugin_configurations.zsh"
# fi
#
# # Load pyenv if available
# if [[ -f "$ZDOTDIR/.zpyenv" ]]; then
#   source "$ZDOTDIR/.zpyenv"
# fi
#
# # Set up editor configurations
# if [[ -f "$ZDOTDIR/.zeditor" ]]; then
#   source "$ZDOTDIR/.zeditor"
# fi
#
# # Load tools configurations if present
# if [[ -f "$ZDOTDIR/.ztools" ]]; then
#   source "$ZDOTDIR/.ztools"
# fi
#
# # Set up any color settings, e.g., Catppuccin theme
# if [[ -f "$ZDOTDIR/.zcolors_catppuccin" ]]; then
#   source "$ZDOTDIR/.zcolors_catppuccin"
# fi
#
# # Load user-defined aliases if present
# if [[ -f "$ZDOTDIR/.zaliases" ]]; then
#   source "$ZDOTDIR/.zaliases"
# fi
#
# # Load package configurations if present
# if [[ -f "$ZDOTDIR/.zpackages" ]]; then
#   source "$ZDOTDIR/.zpackages"
# fi

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG_ENDFILE "${(%):-%N}"
