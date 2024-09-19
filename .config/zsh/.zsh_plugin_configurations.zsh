# vim: filetype=zsh

### Plugins settings
#################################################################################

### ohmysh/ohmyzsh ###
# dotenv
export ZSH_DOTENV_PROMPT=false

# alias-finder
if [ -d "$(antidote path ohmyzsh/ohmyzsh)/plugins/alias-finder" ]; then
    zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
    zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
    zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
    zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default
fi

# sudo
# Esc=Esc
if [ -d "$(antidote path ohmyzsh/ohmyzsh)/plugins/sudo" ]; then
    bindkey -M emacs '^[^[' sudo-command-line
    bindkey -M vicmd '^[^[' sudo-command-line
    bindkey -M viins '^[^[' sudo-command-line
fi

# eza
if [ -d "$(antidote path ohmyzsh/ohmyzsh)/plugins/eza" ]; then
    zstyle ':omz:plugins:eza' 'dirs-first' yes
    zstyle ':omz:plugins:eza' 'git-status' yes
    zstyle ':omz:plugins:eza' 'header' yes
    zstyle ':omz:plugins:eza' 'icons' yes
    zstyle ':omz:plugins:eza' 'size-prefix' binary
fi

### zsh-users/zsh-history-substring-search ###
if antidote path "zsh-users/zsh-history-substring-search" > /dev/null 2&>1; then
    export HISTORY_SUBSTRING_SEARCH_FUZZY=0
    export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=#1e1e2e,bg=#a6e3a1,bold,underline"
    export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=#1e1e2e,bg=#f38ba8,bold,underline"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    # if the above doesn't work
    # bindkey "$terminfo[kcuu1]" history-substring-search-up
    # bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down
    # bindkey -M viins '^P' history-substring-search-up
    # bindkey -M viins '^N' history-substring-search-down
    bindkey -M vicmd 'K' history-substring-search-up
    bindkey -M vicmd 'J' history-substring-search-down
fi

# per-directory-history
if [ -d "$(antidote path ohmyzsh/ohmyzsh)/plugins/per-directory-history" ]; then
  export HISTORY_START_WITH_GLOBAL=false
  export PER_DIRECTORY_HISTORY_TOGGLE='^G'
  export PER_DIRECTORY_HISTORY_PRINT_MODE_CHANGE=true
  export HISTORY_BASE="${ZDOTDIR}/.directory_history"
fi

### zsh-users/zsh-autosuggestions ###
if antidote path "zsh-users/zsh-autosuggestions" > /dev/null 2>&1; then
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a6e3a1,bg=#1e1e2e,italic"
    export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

### marlonrichert/zsh-autocomplete
if antidote path "marlonrichert/zsh-autocomplete" > /dev/null 2>&1; then
    # zstyle '*:compinit' arguments -D -i -u -C -w
    bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
    bindkey -M viins '\t' menu-select "$terminfo[kcbt]" menu-select
    bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
    zstyle ':autocomplete:*' add-space \
        history executables aliases functions builtins reserved-words commands
fi

### MichaelAquilina/zsh-you-should-use ###
if antidote path "MichaelAquilina/zsh-you-should-use" > /dev/null 2>&1; then
    export YSU_MESSAGE_POSITION="after"
    export YSU_MODE=ALL
    export zs_set_path=1
    # basic file preview for ls (you can replace with something more sophisticated than head)
    zstyle ':completion::*:ls::*' fzf-completion-opts --preview='eval head {1}'
    # preview when completing env vars (note: only works for exported variables)
    # eval twice, first to unescape the string, second to expand the $variable
    zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval eval echo {1}'
    # preview a `git status` when completing git add
    zstyle ':completion::*:git::git,add,*' fzf-completion-opts --preview='git -c color.status=always status --short'
    # if other subcommand to git is given, show a git diff or git log
    zstyle ':completion::*:git::*,[a-z]*' fzf-completion-opts --preview='
    eval set -- {+1}
    for arg in "$@"; do
        { git diff --color=always -- "$arg" | git log --color=always "$arg" } 2>/dev/null
    done'
fi

### wofr06/lesspipe ###
if antidote path "wofr06/lesspipe" > /dev/null 2>&1; then
    export LESSOPEN
    LESSOPEN="|$(antidote path 'wofr06/lesspipe')/lesspipe.sh %s"
fi

### fast-syntax-highlighting ###
if antidote path "zdharma-continuum/fast-syntax-highlighting" > /dev/null 2&>1; then
    local fast_theme="$(antidote path zdharma-continuum/fast-syntax-highlighting)"
    fast_theme="$fast_theme/fast-syntax-highlighting.plugin.zsh"
    [[ -f "$fast_theme" ]] && \
      source "$fast_theme" && \
      fast-theme --quiet XDG:catppuccin-mocha

    chroma_single_word() {
      (( next_word = 2 | 8192 ))

      local __first_call="$1" __wrd="$2" __start_pos="$3" __end_pos="$4"
      local __style

      (( __first_call )) && \
          { __style=${fast_theme_name}alias }

      [[ -n "$__style" ]] && \
          (( __start=__start_pos-${#prebuffer}, __end=__end_pos-${#prebuffer}, __start >= 0 )) && \
          reply+=("$__start $__end ${fast_highlight_styles[$__style]}")

      (( this_word = next_word ))
      _start_pos=$_end_pos

      return 0
    }

    register_single_word_chroma() {
      local word=$1
      if [[ -x $(command -v $word) ]] || [[ -n $fast_highlight["chroma-$word"] ]]; then
        return 1
      fi

      fast_highlight+=( "chroma-$word" chroma_single_word )
      return 0
    }

    if command -v abbr &>/dev/null; then
      if [[ -n $fast_highlight ]]; then
        for abbr in ${(f)"$(abbr list-abbreviations)"}; do
          if [[ $abbr != *' '* ]]; then
            register_single_word_chroma ${(q)abbr}
          fi
        done
      fi
    fi
fi

### jeffreytse/zsh-vi-mode ###
if antidote path "jeffreytse/zsh-vi-mode" > /dev/null 2>&1; then
    zvm_config
fi

### tom-doerr/zsh_codex ###
if antidote path "tom-doerr/zsh_codex > /dev/null 2>&1; then
    bindkey '^X' create_completion
fi
