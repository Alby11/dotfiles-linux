#!/usr/bin/fish
# aliases.fish

# bat-extras
if command -v bat > /dev/null
    alias B 'bat --show-all'
end

if command -v batgrep > /dev/null
    alias BG 'batgrep --ignore-case --color'
    alias bgrep 'batgrep --ignore-case --color'
end

if command -v batman > /dev/null
    alias bman 'batman k'
end

if command -v batdiff > /dev/null
    alias bdiff 'batdiff'
end

if command -v batwatch > /dev/null
    alias bwatch 'batwatch'
end

alias sudo "sudo "
alias Sb "source ~/.bashrc"
alias Sba "source ~/.bash_aliases"
alias Sbe "source ~/.bash_exports"
alias Sz "source \$ZDOTDIR/.zshrc"
alias Sza "source \$ZDOTDIR/aliases.sh"
alias Sze "source \$ZDOTDIR/exports.sh"
alias Szf "source \$ZDOTDIR/functions.sh"
alias C "clear"
alias dfh 'sudo df -h'
alias freeh 'sudo free -mh'
alias EE 'exit'
alias chmod 'sudo chmod '
alias chown 'sudo chown '
alias h "history -10" # last 10 history commands
alias hh "history -20" # last 10 history commands
alias hhh "history -30" # last 10 history commands

if command -v ss > /dev/null
    alias ssa 'sudo ss -poeta '
end

if command -v notify-send > /dev/null
    # Credits to: https://gist.github.com/Feniksovich
    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    function alert
        notify-send --urgency=low -i \
            (if test $status = 0; echo terminal; else; echo error; end) \
            (history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')
    end
end

if command -v systemctl > /dev/null
    # Basic systemctl commands
    alias systemctl "sudo systemctl "
    alias ctl "systemctl "
    alias sctl "/bin/systemctl"
    # Daemons reload
    alias ctldr "systemctl daemon-reload"
    # Credits to: https://gist.github.com/Feniksovich
    alias ctlsp "systemctl stop "
    alias ctlst "systemctl start "
    alias ctlrt "systemctl restart "
    alias ctlrl "systemctl reload "
    alias ctls "systemctl status "
    # Enable/Disable commands for units
    alias ctle 'systemctl enable '
    alias ctld 'systemctl disable '
    # Masking Units to disabling them
    alias ctlmask 'systemctl mask '
    alias ctlunmask 'systemctl unmask '
    # List failed units and reset systemd system status
    alias ctlfailed 'systemctl --failed --all '
    alias ctlrf 'systemctl reset-failed '
end

if command -v iptables > /dev/null
    alias it 'iptables '
    # Lookup iptables chain
    alias itlookup "iptables --line-numbers -nvL "
end

if command -v journalctl > /dev/null
    alias j "journalctl"
    alias jf "journalctl --follow"
    alias ju "journalctl --catalog --pager-end --unit"
    alias juf "journalctl --follow --catalog --unit"
    alias jfk "journalctl --follow --dmesg"
end

if command -v apt > /dev/null
    alias apt 'sudo apt '
    alias apts 'sudo apt search '
    alias aptu 'sudo apt update '
    alias aptup 'sudo apt upgrade -y '
    alias aptdup 'sudo apt dist-upgrade -y '
    alias apti 'sudo apt install -y '
    alias aptr 'sudo apt remove '
    alias aptar 'sudo apt autoremove '
    alias aptap 'sudo apt autopurge '
end

if command -v dnf > /dev/null
    alias dnf 'sudo dnf '
    alias dnfs 'sudo dnf search '
    alias dnfp 'sudo dnf provides '
    alias dnff 'sudo dnf info '
    alias dnfl 'sudo dnf list '
    alias dnfli 'sudo dnf list --installed '
    alias dnfq 'sudo dnf repoquery '
    alias dnfcu 'sudo dnf check-update '
    alias dnfup 'sudo dnf upgrade -y '
    alias dnfds 'sudo dnf distro-sync -y '
    alias dnfi 'sudo dnf install -y '
    alias dnfr 'sudo dnf remove '
    alias dnfar 'sudo dnf autoremove '
    alias dnfk 'sudo dnf copr '
    alias dnfuua 'dnfcu ; dnfup ; dnfar'
end

if command -v tmux > /dev/null
    alias T 'tmux'
    alias tls 'tmux ls'
    alias ta 'tmux attach -t'
    alias tn 'tmux new -s'
    alias trs 'tmux rename-session -t'
    alias tk 'tmux kill-session -t'
end

if command -v nvim > /dev/null
    alias e "nvim"
    alias nv "nvim"
    alias vi "nvim"
    alias vim "nvim"
    
    if command -v nvr > /dev/null
        alias nvimr "nvim --listen /tmp/nvimsocket"
        alias nvrs "nvr -s"
    end
end

if command -v xclip > /dev/null
  # Credits to: https://gist.github.com/Feniksovich
  # Copy to clipboard
  # Usage: echo "hello" | Xy
  # Paste from clipboard
  # Usage: Xp
  # Usage: echo $(Xp)
  # Usage: echo (Xp)
  # Usage: echo `Xp`
  # Usage: echo "$(Xp)"
  # Usage: echo "(Xp)"
  # Usage: echo "`Xp`"
  # Usage: echo "$(Xp)"
  # Usage: echo "(Xp)"
  # Usage: echo "`Xp`"
  # Usage: echo "$(Xp)"
  # Usage: echo "(Xp)"
  # Usage: echo "`Xp`"
  # Usage: echo "$(Xp)"
  # Usage: echo "(Xp)"
  # Usage: echo "`Xp`"
  # Usage: echo "$(Xp)"
  # Usage: echo "(Xp)"
  # Usage: echo "`Xp`"
  # Usage: echo "$(Xp)"
  # Usage: echo "(Xp)"
  # Usage: echo "`Xp`"
  # Usage: echo "$(Xp)"
  # Usage: echo "(Xp)"
  # Usage: echo "`Xp`"
  # Usage: Xy < file.txt
  #
  
  	alias Xy "xclip -i "
  	alias Xp "xclip -o "
end

if command -v clipboard > /dev/null
    alias Cp "clipboard"
    alias Cy "clipboard"
end

if command -v wl-copy > /dev/null
    alias Wp "wl-paste"
    alias Wy "wl-copy"
end

if command -v ranger > /dev/null
    alias rw "ranger"
end

if command -v fdfind > /dev/null
    alias fd "fdfind"
end

if command -v zoxide > /dev/null
    echo 
end

if command -v exa > /dev/null
    alias ola "/bin/ls -lahi --color=auto"
    alias ols "/bin/ls --color=auto"
    alias ls "exa --icons --git --group-directories-first"
    alias ll "exa -lg --icons --git --group-directories-first"
    alias la "exa -aglm --icons --git --group-directories-first"
    alias lt "exa -L 2 --icons --tree --git-ignore --group-directories-first"
end

if command -v git > /dev/null
    alias g "git"
    alias dot "dotfiles"
end

if command -v kubectl > /dev/null
    source (kubectl completion fish | psub)
    alias k 'kubectl'
end

if command -v minikube > /dev/null
    source (minikube completion fish | psub)
    alias mk 'minikube'
end

if command -v docker > /dev/null
    source (docker completion fish | psub)
    alias dk 'docker'
    alias dkc 'docker-compose'
end

if command -v ansible > /dev/null
    alias a 'ansible'
    alias ap 'ansible-playbook'
    alias ag 'ansible-galaxy'
end

if command -v podman > /dev/null
    source (podman completion fish | psub)
    alias pd 'podman'
end

alias xway 'env -u WAYLAND_DISPLAY'

if command -v curl > /dev/null
    # Creditst to Jeremy "Jay" LaCroix
    # <https://www.learnlinux.tv/10-linux-terminal-tips-and-tricks-to-enhance-your-workflow/
    alias speedtest 'curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
    # alias myip 'curl http://ipecho.net/plain; echo '
    alias myip 'curl icanhazip.com'
    # alias wimp 'curl https://wttr.in/imperia'
    alias wimp 'wth imperia'
end

alias resetSound '/bin/systemctl --user restart pipewire.service'

# PIP block 
if command -v pip > /dev/null
    alias pipi 'pip install '
    alias pipiu 'pip install --user '
    alias pipu 'pip uninstall '
    alias pipuu 'pip uninstall --user '
end
# end of PIP block
