# vim: filetype=zsh
#
# .zlogin
#

ECHOCAT """
.zlogin - Zsh file loaded lastly on login shell, after .zshrc.
"""

[[ -e $ZSH_DEBUG ]] && ZSH_DEBUG_LOG "${(%):-%N}"
