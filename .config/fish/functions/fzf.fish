set FZF_BASE /usr/bin/fzf
set FZF_DEFAULT_COMMAND 'rg --ignore-case --files --no-ignore-vcs --hidden '
# catppucin theme
set FZF_DEFAULT_OPTS " --preview bat --border=rounded \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  ;"
    
function fzfb
    if not command -v fzf > /dev/null
        echo "fzf command not found"
        return 1
    end

    if not command -v rg > /dev/null
        echo "rg command not found"
        return 1
    end

    if not command -v bat > /dev/null
        echo "bat command not found"
        return 1
    end

    fzf \
    --preview bat --border=rounded \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    ;
end
