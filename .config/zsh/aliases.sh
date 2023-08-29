#!/usr/bin/zsh
# aliases

theShell=$(echo "$SHELL" | cut -d '/' -f 3)

# if 'alias -g' is available, define an alias that can be used on zshrc
# but doesn't brake everything if we are on bash
if [[ $? == 0 ]] # I know, it's dirty...
then 
  alias -g aliasG="alias -g "
else
  alias aliasG="alias "
fi
  aliasG grep='grep --color=auto '
  aliasG G=' | grep -i '
# bat-extras
if command -v bat &>/dev/null
then
  aliasG B=' | bat --show-all'
fi
if command -v batgrep &>/dev/null
then
  aliasG BG=' | batgrep --ignore-case --color '
  aliasG bgrep='batgrep --ignore-case --color '
fi
if command -v batman &>/dev/null
then
  aliasG bman='batman k'
fi
if command -v batdiff &>/dev/null
then
  aliasG bdiff=' | batdiff '
fi
if command -v batwatch &>/dev/null
then
  aliasG bwatch='batwatch '
fi
aliasG sudo="sudo "
aliasG Sb="source ~/.bashrc"
aliasG Sba="source ~/.bash_aliases"
aliasG Sbe="source ~/.bash_exports"
aliasG Sz="source \$ZDOTDIR/.zshrc"
aliasG Sza="source \$ZDOTDIR/aliases.sh"
aliasG Sze="source \$ZDOTDIR/exports.sh"
aliasG C="clear"
aliasG dfh='sudo df -h'
aliasG freeh='sudo free -mh'
aliasG EE='exit'
aliasG chmod='sudo chmod '
aliasG chown='sudo chown '
aliasG h="history -10" # last 10 history commands
aliasG hh="history -20" # last 10 history commands
aliasG hhh="history -30" # last 10 history commands

if command -v ss &>/dev/null; then
    alias ssa='sudo ss -poeta '
fi

if command -v notify-send &>/dev/null; then
  # Credits to: https://gist.github.com/Feniksovich
  # Add an "alert" alias for long running commands.  Use like so:
  #   sleep 10; alert
  alias alert='notify-send --urgency=low -i \
    "$([ $? = 0 ] && echo terminal || \
  echo error)" "$(history|tail -n1 | \
    sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' \
    ;
fi

if command -v systemctl &>/dev/null; then
    # Basic systemctl commands
    aliasG systemctl="sudo systemctl "
    aliasG systemctl="sudo systemctl "
    aliasG ctl="systemctl "
    aliasG sctl="/bin/systemctl"
    # Daemons reload
    aliasG ctldr="systemctl daemon-reload"
    # Credits to: https://gist.github.com/Feniksovich
    aliasG ctlsp="systemctl stop "
    aliasG ctlst="systemctl start "
    aliasG ctlrt="systemctl restart "
    aliasG ctlrl="systemctl reload "
    aliasG ctls="systemctl status "
    # Enable/Disable commands for units
    aliasG ctle='systemctl enable '
    aliasG ctld='systemctl disable '
    # Masking Units to disabling them
    aliasG ctlmask='systemctl mask '
    aliasG ctlunmask='systemctl unmask '
    # List failed units and reset systemd system status
    aliasG ctlfailed='systemctl --failed --all '
    aliasG ctlrf='systemctl reset-failed '
fi

if command -v iptables &>/dev/null; then
    aliasG it='iptables '
    # Lookup iptables chain
    aliasG itlookup="iptables --line-numbers -nvL "
fi

if command -v journalctl &>/dev/null; then
    aliasG j="journalctl"
    aliasG jf="journalctl --follow"
    aliasG ju="journalctl --catalog --pager-end --unit"
    aliasG juf="journalctl --follow --catalog --unit"
    aliasG jfk="journalctl --follow --dmesg"
fi

if command -v apt &>/dev/null; then
    aliasG apt='sudo apt '
    aliasG apts='sudo apt search '
    aliasG aptp='sudo dpkg '
    aliasG aptf='sudo apt show '
    aliasG aptl='sudo apt list '
    aliasG aptlu='sudo apt list --upgradable'
    aliasG aptli='sudo apt list --installed'
    aliasG aptu='sudo apt update '
    aliasG aptup='sudo apt upgrade -y '
    aliasG aptdup='sudo apt dist-upgrade -y '
    aliasG apti='sudo apt install -y '
    aliasG aptr='sudo apt remove '
    aliasG aptar='sudo apt autoremove '
    aliasG aptap='sudo apt autopurge '
fi

if command -v dnf &>/dev/null; then
    aliasG dnf='sudo dnf '
    aliasG dnfs='sudo dnf search '
    aliasG dnfp='sudo dnf provides '
    aliasG dnff='sudo dnf info '
    aliasG dnfl='sudo dnf list '
    aliasG dnfli='sudo dnf list --installed '
    aliasG dnfq='sudo dnf repoquery '
    aliasG dnfcu='sudo dnf check-update '
    aliasG dnfup='sudo dnf upgrade -y '
    aliasG dnfds='sudo dnf distro-sync -y '
    aliasG dnfi='sudo dnf install -y '
    aliasG dnfr='sudo dnf remove '
    aliasG dnfar='sudo dnf autoremove '
    aliasG dnfk='sudo dnf copr '
    aliasG dnfuua='sudo dnfcu ; dnfup ; dnfar'
fi


if command -v tmux &>/dev/null; then
    aliasG T='tmux '
    aliasG tls='tmux ls '
    aliasG ta='tmux attach -t '
    aliasG tn='tmux new -s '
    aliasG trs='tmux rename-session -t '
    aliasG tk='tmux kill-session -t '
fi

if command -v nvim &>/dev/null; then
    aliasG e='nvim '
    aliasG nv='nvim '
    aliasG vi='nvim '
    aliasG vim='nvim '
    aliasG E='| nvim '
    if command -v nvr &>/dev/null; then
        aliasG nvimr='nvim --listen /tmp/nvimsocket '
        aliasG nvrs='nvr -s '
    fi
fi

if command -v xclip &>/dev/null; then
    aliasG Xp='xclip -o '
    aliasG Xy=' | xclip -i '
fi
if command -v clipboard &>/dev/null; then
    aliasG Cp="clipboard "
    aliasG Cy=' | clipboard '
fi
if command -v wl-copy &>/dev/null; then
    aliasG Wp="wl-paste "
    aliasG Wy=' | wl-copy '
fi

if command -v ranger &>/dev/null; then
    aliasG rw='ranger '
fi

if command -v fdfind &>/dev/null; then
    aliasG fd='fdfind '
fi

if command -v zoxide &>/dev/null; then
    # aliasG cd='z '
    echo
fi

if command -v exa &>/dev/null; then
    aliasG ola='/bin/ls -lahi --color=auto '
    aliasG ols='/bin/ls --color=auto '
    aliasG ls="exa --icons --git --group-directories-first "
    aliasG ll="exa -lg --icons --git --group-directories-first "
    aliasG la="exa -aglm --icons --git --group-directories-first "
    aliasG lt="exa -L 2 --icons --tree --git-ignore --group-directories-first "
fi

if command -v git &>/dev/null; then
    aliasG g='git '
    aliasG dot='dotfiles '
fi

if command -v kubectl &>/dev/null; then
    source <(kubectl completion "$theShell")
    aliasG k='kubectl '
fi

if command -v minikube &>/dev/null; then
    source <(minikube completion "$theShell")
    aliasG mk='minikube '
fi

if command -v docker &>/dev/null; then
    source <(docker completion "$theShell")
    aliasG dk='docker '
    aliasG dkc='docker-compose '
fi

if command -v ansible &>/dev/null; then
    aliasG a='ansible '
    aliasG ap='ansible-playbook '
    aliasG ag='ansible-galaxy '
fi

if command -v podman &>/dev/null; then
    source <(podman completion "$theShell")
    aliasG pd='podman '
fi

aliasG xway='env -u WAYLAND_DISPLAY '

if command -v curl &>/dev/null; then
    # Creditst to Jeremy "Jay" LaCroix
    # <https://www.learnlinux.tv/10-linux-terminal-tips-and-tricks-to-enhance-your-workflow/
    aliasG speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
    # aliasG myip='curl http://ipecho.net/plain; echo '
    aliasG myip='curl icanhazip.com'
    # aliasG wimp='curl https://wttr.in/imperia'
    aliasG wimp='wth imperia'
fi

if [ "$(command -v fzf)" ] && [ "$(command -v rg)" ] && [ "$(command -v bat)" ]; then
    export FZF_BASE=/usr/bin/fzf
    export FZF_DEFAULT_COMMAND='rg --ignore-case --files --no-ignore-vcs --hidden '
    # catppucin theme
    export FZF_DEFAULT_OPTS=" --preview bat --border=rounded \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
;"
    aliasG fzfb="fzf \
--preview bat --border=rounded \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
;"
    # dracula theme
    # export FZF_DEFAULT_OPTS="\
        # --preview bat --border=rounded  \
        # --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
        # --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
        # --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
        # --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 \
        # ;"
    # DISABLE_FZF_AUTO_COMPLETION="false"
    # DISABLE_FZF_KEY_BINDINGS="true"
    # alias fzfb="fzf \
        # # --preview bat --color=always --style=numbers --line-range=:500 {} \
        # --preview bat --border=rounded  \
        # --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
        # --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
        # --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
        # --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 \
        # ;"
    aliasG R='| rg '
else
    echo "fzf|rg|bat missing..."
fi

aliasG resetSound='/bin/systemctl --user restart pipewire.service'

# PIP block 
if command -v pip &>/dev/null
then
  aliasG pipi='pip install '
  aliasG pipiu='pip install --user '
  aliasG pipu='pip uninstall '
  aliasG pipuu='pip uninstall --user '
fi
# end of PIP block
### dot: git adaptation for dotfiles
aliasG d='dot '
aliasG da='dot add'
aliasG daa='dot add --all'
aliasG dam='dot am'
aliasG dama='dot am --abort'
aliasG damc='dot am --continue'
aliasG dams='dot am --skip'
aliasG damscp='dot am --show-current-patch'
aliasG dap='dot apply'
aliasG dapa='dot add --patch'
aliasG dapt='dot apply --3way'
aliasG dau='dot add --update'
aliasG dav='dot add --verbose'
aliasG db='dot branch'
aliasG dbD='dot branch --delete --force'
aliasG dba='dot branch --all'
aliasG dbd='dot branch --delete'
aliasG dbda='dot branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs dot branch --delete 2>/dev/null'
aliasG dbg='LANG=C dot branch -vv | grep ": gone\]"'
aliasG dbgD='LANG=C dot branch --no-color -vv | grep ": gone\]" | awk '\''{print $1}'\'' | xargs dot branch -D'
aliasG dbgd='LANG=C dot branch --no-color -vv | grep ": gone\]" | awk '\''{print $1}'\'' | xargs dot branch -d'
aliasG dbl='dot blame -b -w'
aliasG dbnm='dot branch --no-merged'
aliasG dbr='dot branch --remote'
aliasG dbs='dot bisect'
aliasG dbsb='dot bisect bad'
aliasG dbsg='dot bisect good'
aliasG dbsr='dot bisect reset'
aliasG dbss='dot bisect start'
aliasG dc='<EUGPSCoordinates>commit <EUGPSCoordinates>--verbose' 
aliasG 'dc!'='<EUGPSCoordinates>commit <EUGPSCoordinates>--verbose <EUGPSCoordinates>--amend' 
aliasG dca='<EUGPSCoordinates>commit <EUGPSCoordinates>--verbose <EUGPSCoordinates>--all' 
aliasG 'dca!'='<EUGPSCoordinates>commit <EUGPSCoordinates>--verbose <EUGPSCoordinates>--all <EUGPSCoordinates>--amend' 
aliasG dcam='<EUGPSCoordinates>commit <EUGPSCoordinates>--all <EUGPSCoordinates>--message' 
aliasG 'dcan!'='<EUGPSCoordinates>commit <EUGPSCoordinates>--verbose <EUGPSCoordinates>--all <EUGPSCoordinates>--no-edit <EUGPSCoordinates>--amend' 
aliasG 'dcans!'='<EUGPSCoordinates>commit <EUGPSCoordinates>--verbose <EUGPSCoordinates>--all <EUGPSCoordinates>--signoff <EUGPSCoordinates>--no-edit <EUGPSCoordinates>--amend' 
aliasG dcas='<EUGPSCoordinates>commit <EUGPSCoordinates>--all <EUGPSCoordinates>--signoff' 
aliasG dcasm='<EUGPSCoordinates>commit <EUGPSCoordinates>--all <EUGPSCoordinates>--signoff <EUGPSCoordinates>--message' 
aliasG dcb='<EUGPSCoordinates>checkout -b' 
aliasG dcd='<EUGPSCoordinates>checkout $(<EUGPS'
aliasG dcf='dot config --list'
aliasG dcl='dot clone --recurse-submodules'
aliasG dclean='dot clean --interactive -d'
aliasG dcm='dot checkout $(git_main_branch)'
aliasG dcmsg='dot commit --message'
aliasG dcn!='dot commit --verbose --no-edit --amend'
aliasG dco='dot checkout'
aliasG dcor='dot checkout --recurse-submodules'
aliasG dcount='dot shortlog --summary --numbered'
aliasG dcp='dot cherry-pick'
aliasG dcpa='dot cherry-pick --abort'
aliasG dcpc='dot cherry-pick --continue'
aliasG dcs='dot commit --gpg-sign'
aliasG dcsm='dot commit --signoff --message'
aliasG dcss='dot commit --gpg-sign --signoff'
aliasG dcssm='dot commit --gpg-sign --signoff --message'
aliasG dd='dot diff'
aliasG ddca='dot diff --cached'
aliasG ddct='dot describe --tags $(dot rev-list --tags --max-count=1)'
aliasG ddcw='dot diff --cached --word-diff'
aliasG dds='dot diff --staged'
aliasG ddt='dot diff-tree --no-commit-id --name-only -r'
aliasG ddup='dot diff @{upstream}'
aliasG ddw='dot diff --word-diff'
aliasG df='<EUGPSCoordinates>fetch' 
aliasG dfa='<EUGPSCoordinates>fetch <EUGPSCoordinates>--all <EUGPSCoordinates>--prune <EUGPSCoordinates>--jobs=10' 
aliasG dfg='<EUGPSCoordinates>ls-files | grep' 
aliasG dfo='<EUGPSCoordinates>fetch origin' 
aliasG dg='<EUGPSCoordinates>gui citool' 
aliasG dga='<EUGPSCoordinates>gui citool <EUGPSCoordinates>--amend' 
aliasG dgpull='<EUGPSCoordinates>pull origin "$(<EUGPSCoordinates>_current_branch)"' 
aliasG dgpush='<EUGPSCoordinates>push origin "$(<EUGPSCoordinates>_current_branch)"' 
aliasG dgsup='<EUGPSCoordinates>branch <EUGPSCoordinates>--set-upstream-to=origin/$(<EUGPSCoordinates>_current_branch)' 
aliasG dhh='<EUGPSCoordinates>help' 
aliasG dignore='<EUGPSCoordinates>update-index <EUGPSCoordinates>--assume-unchanged' 
aliasG dignored='<EUGPSCoordinates>ls-files -v | grep "^[[:lower:]]"' 
aliasG dit-svn-dcommit-push='<EUGPSCoordinates>svn dcommit && <EUGPSCoordinates>push github $(<EUGPSCoordinates>_main_branch):svntrunk' 
aliasG dpv="dot push --verbose"
aliasG dhub='web_search github'
aliasG dk='\gitk --all --branches &!'
aliasG dke='\gitk --all $(dot log --walk-reflogs --pretty=%h) &!'
aliasG dl='dot pull'
aliasG dlg='dot log --stat'
aliasG dlgg='dot log --graph'
aliasG dlgga='dot log --graph --decorate --all'
aliasG dlgm='dot log --graph --max-count=10'
aliasG dlgp='dot log --stat --patch'
aliasG dlo='dot log --oneline --decorate'
aliasG dlod='dot log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
aliasG dlods='dot log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
aliasG dlog='dot log --oneline --decorate --graph'
aliasG dloga='dot log --oneline --decorate --graph --all'
aliasG dlol='dot log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
aliasG dlola='dot log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
aliasG dlols='dot log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
aliasG dlp=_git_log_prettily
aliasG dluc='dot pull upstream $(git_current_branch)'
aliasG dlum='dot pull upstream $(git_main_branch)'
aliasG dm='dot merge'
aliasG dma='dot merge --abort'
aliasG dmom='dot merge origin/$(git_main_branch)'
aliasG dms='dot merge --squash'
aliasG dmtl='dot mergetool --no-prompt'
aliasG dmtlvim='dot mergetool --no-prompt --tool=vimdiff'
aliasG dmum='dot merge upstream/$(git_main_branch)'
aliasG dp='dot push'
aliasG dpd='dot push --dry-run'
aliasG dpf='dot push --force-with-lease --force-if-includes'
aliasG 'dpf!'='dot push --force'
aliasG dpoat='dot push origin --all && dot push origin --tags'
aliasG dpod='dot push origin --delete'
aliasG dpr='dot pull--rebase'
aliasG dpristine='dot reset--hard && dot clean--force-dfx'
aliasG dpsup='dot push --set-upstream origin $(git_current_branch)'
aliasG dpsupf='dot push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
aliasG du='dot push upstream'
aliasG dv='dot push --verbose'
aliasG dr='dot remote'
aliasG dra='dot remote add'
aliasG drb='dot rebase'
aliasG drba='dot rebase --abort'
aliasG drbc='dot rebase --continue'
aliasG drbd='dot rebase $(git_develop_branch)'
aliasG drbi='dot rebase --interactive'
aliasG drbm='dot rebase $(git_main_branch)'
aliasG drbo='dot rebase --onto'
aliasG drbom='dot rebase origin/$(git_main_branch)'
aliasG drbs='dot rebase --skip'
aliasG drev='dot revert'
aliasG drh='dot reset'
aliasG drhh='dot reset --hard'
aliasG drm='dot rm'
aliasG drmc='dot rm --cached'
aliasG drmv='dot remote rename'
aliasG droh='dot reset origin/$(git_current_branch) --hard'
aliasG drrm='dot remote remove'
aliasG drs='dot restore'
aliasG drset='dot remote set-url'
aliasG drss='dot restore --source'
aliasG drst='dot restore --staged'
aliasG drt='cd "$(dot rev-parse --show-toplevel || echo .)"'
aliasG dru='dot reset --'
aliasG drup='dot remote update'
aliasG drv='dot remote --verbose'
aliasG dsb='dot status --short --branch'
aliasG dsd='dot svn dcommit'
aliasG dsh='dot show'
aliasG dsi='dot submodule init'
aliasG dsps='dot show --pretty=short --show-signature'
aliasG du='dot push upstream'
aliasG dv='dot push --verbose'
aliasG dr='dot remote'
aliasG dra='dot remote add'
aliasG drb='dot rebase'
aliasG drba='dot rebase --abort'
aliasG drbc='dot rebase --continue'
aliasG drbd='dot rebase $(git_develop_branch)'
aliasG drbi='dot rebase --interactive'
aliasG drbm='dot rebase $(git_main_branch)'
aliasG drbo='dot rebase --onto'
aliasG drbom='dot rebase origin/$(git_main_branch)'
aliasG drbs='dot rebase --skip'
aliasG drev='dot revert'
aliasG drh='dot reset'
aliasG drhh='dot reset --hard'
aliasG drm='dot rm'
aliasG drmc='dot rm --cached'
aliasG drmv='dot remote rename'
aliasG droh='dot reset origin/$(git_current_branch) --hard'
aliasG drrm='dot remote remove'
aliasG drs='dot restore'
aliasG drset='dot remote set-url'
aliasG drss='dot restore --source'
aliasG drst='dot restore --staged'
aliasG drt='cd "$(dot rev-parse --show-toplevel || echo .)"'
aliasG dru='dot reset --'
aliasG drup='dot remote update'
aliasG drv='dot remote --verbose'
aliasG drup='dot remote update'
aliasG drv='dot remote --verbose'
aliasG dsb='dot status --short --branch'
aliasG dsd='dot svn dcommit'
aliasG dsh='dot show'
aliasG dsi='dot submodule init'
aliasG dsps='dot show --pretty=short --show-signature'
aliasG dsr='dot svn rebase'
aliasG dss='dot status --short'
aliasG dst='dot status'
aliasG dsta='dot stash push'
aliasG dstaa='dot stash apply'
aliasG dstall='dot stash --all'
aliasG dstc='dot stash clear'
aliasG dstd='dot stash drop'
aliasG dstl='dot stash list'
aliasG dstp='dot stash pop'
aliasG dsts='dot stash show --text'
aliasG dsu='dot submodule update'
aliasG dsw='dot switch'
aliasG dswc='dot switch --create'
aliasG dswd='dot switch $(git_develop_branch)'
aliasG dswm='dot switch $(git_main_branch)'
aliasG dtl='dtl(){ dot tag --sort=-v:refname -n --list "${1}*" }; noglob dtl'
aliasG dts='dot tag --sign'
aliasG dtv='dot tag | sort -V'
aliasG dunignore='dot update-index --no-assume-unchanged'
aliasG dunwip='dot rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && dot reset HEAD~1'
aliasG dup='dot pull --rebase'
aliasG dupa='dot pull --rebase --autostash'
aliasG dupav='dot pull --rebase --autostash --verbose'
aliasG dupom='dot pull --rebase origin $(dot_main_branch)'
aliasG dupomi='dot pull --rebase=interactive origin $(dot_main_branch)'
aliasG dupv='dot pull --rebase --verbose'
aliasG dwch='dot whatchanged -p --abbrev-commit --pretty=medium'
aliasG dwip='dot add -A; dot rm $(dot ls-files --deleted) 2> /dev/null; dot commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
aliasG dwt='dot worktree'
aliasG dwta='dot worktree add'
aliasG dwtls='dot worktree list'
aliasG dwtmv='dot worktree move'
aliasG dwtrm='dot worktree remove'
### end of dot block
