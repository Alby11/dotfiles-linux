#!/usr/bin/zsh

# Log input arguments for debugging (optional)
echo "Wrapper invoked with arguments: $@" >> ~/tmp/.nvim_wrapper.log

# Detect the mode (diff, merge, pager)
case "$1" in
    difftool|diff)
        nvim -c 'set ft=diff' -c 'BaleiaColorize' -d "${LOCAL:-}" "${REMOTE:-}" -c 'BaleiaColorize'
        ;;
    mergetool|merge)
        nvim -c 'set ft=diff' -c 'BaleiaColorize' -d "${LOCAL:-}" "${REMOTE:-}" "${MERGED:-}" -c 'BaleiaColorize'
        ;;
    pager)
        nvim -c 'set ft=diff' -c 'BaleiaColorize' -
        ;;
    *)
        echo "Unsupported mode: $1" >&2
        exit 1
        ;;
esac
