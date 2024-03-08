# vim: filetype=zsh
#
# .zprofile
#

ECHOCAT """
.zprofile - Zsh file loaded on login shell, right after .zshenv.
and before .zshrc
"""

# export TERM color variable
if [ "$TERM" = "screen" ]; then
	export TERM="screen-256color"
elif [ "$TERM" = "xterm" ]; then
	export TERM="xterm-256color"
fi
export TERM="xterm-256color"
