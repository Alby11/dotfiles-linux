#!/usr/bin/zsh

# Detect the mode (diff, merge, pager)
case "$1" in
    diff|difftool)
        nvim -c 'set ft=diff' -c 'BaleiaColorize' - "$@" -c 'sleep 500m' -c 'BaleiaColorize'
        ;;
    merge|mergetool)
        nvim -c 'set ft=git'  -c 'BaleiaColorize' - "$@" -c 'sleep 500m' -c 'BaleiaColorize'
        ;;
    pager)
        nvim -c 'set ft=git'  -c 'BaleiaColorize' - "$@" -c 'sleep 500m' -c 'BaleiaColorize'
        ;;
    *)
        nvim -c 'set ft=git'  -c 'BaleiaColorize' - "$@" -c 'sleep 500m' -c 'BaleiaColorize'
        ;
esac
