#!/usr/bin/zsh
#functions

fastping() {
    ping -c 100 -s 2
}

chx() {
    chmod +x "$1"
}
chxr() {
    chmod -R +x "$1"
}
dush() {
    if [ -n "$ZSH_VERSION" ]; then
        setopt +o nomatch
        du -hs "$1"/.[^.]* "$1"/*
        setopt -o nomatch
    elif [ -n "$BASH_VERSION" ]; then
        if compgen -G "$1"/.[^.]* > /dev/null; then
            du -hs "$1"/.[^.]* "$1"/*
        else
            du -hs "$1"/*
        fi
    else
        echo "Unsupported shell"
    fi
}
sudush() {
    if [ -n "$ZSH_VERSION" ]; then
        setopt +o nomatch
        sudo du -hs "$1"/.[^.]* "$1"/*
        setopt -o nomatch
    elif [ -n "$BASH_VERSION" ]; then
        if compgen -G "$1"/.[^.]* > /dev/null; then
            sudo du -hs "$1"/.[^.]* "$1"/*
        else
            sudo du -hs "$1"/*
        fi
    else
        echo "Unsupported shell"
    fi
}

hg() {
    history | grep "$1" # +command
}
alias nta='sudo netstat -poeta '
psa() {
    sudo ps -aux
}

if command -v systemctl &>/dev/null; then
    # Basic systemctl commands
    alias systemctl="sudo systemctl "
    alias ctl="systemctl "
    # Daemons reload
    alias ctldr="systemctl daemon-reload"
    # Credits to: https://gist.github.com/Feniksovich
    alias ctlsp="systemctl stop "
    alias ctlst="systemctl start "
    alias ctlrt="systemctl restart "
    alias ctlrl="systemctl reload "
    alias ctls="systemctl status "

    # Enable/Disable commands for units
    alias ctle='systemctl enable '
    alias ctld='systemctl disable '

    # Start and then view status of service
    ctlsts() {
        sudo systemctl start "$1"
        sudo systemctl status "$1"
    }

    # Restart and then view status of service
    ctlrts() {
        sudo systemctl restart "$1"
        sudo systemctl status "$1"
    }
    # Stop and then view status of service
    ctlsps() {
        sudo systemctl stop "$1"
        sudo systemctl status "$1"
    }

    _ctl_completion() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local services=$(systemctl list-unit-files --type=service --state=enabled,disabled | awk '{print $1}')
        COMPREPLY=( $(compgen -W "ctlsts ctlrts ctlsps $services" -- $cur) )
    }

    complete -F _ctl_completion ctlsts
    complete -F _ctl_completion ctlrts
    complete -F _ctl_completion ctlsps

    # Masking Units to disabling them
    alias ctlmask='systemctl mask '
    alias ctlunmask='systemctl unmask '

    # List failed units and reset systemd system status
    alias ctlfailed='systemctl --failed --all '
    alias ctlrf='systemctl reset-failed '

    ### Start of ctlact block
    # The ctlact function is a utility for managing systemd services.
    # It takes an action (start, stop, restart, or status) as the first argument
    # and one or more service names as additional arguments.
    # The function performs the specified action on all the specified services
    # and then displays their status.
    #
    # Usage: ctlact ACTION SERVICE [SERVICE...]
    #
    # Examples:
    #   ctlact restart apache2 nginx
    #   ctlact status sshd
    # Credits: ChatGPT
    ctlact() {
      local action=$1
      shift
      for service in "$@"; do
        systemctl $action $service
        systemctl status $service
      done
    }
    _ctlact() {
        local cur prev opts
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        opts="start stop restart status"

        if [[ ${prev} == ctlact ]]; then
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
        fi

        if [[ ${prev} == start || ${prev} == stop || ${prev} == restart || ${prev} == status ]]; then
            COMPREPLY=( $(compgen -W "$(systemctl list-unit-files --type=service | awk '{print $1}')" -- ${cur}) )
            return 0
        fi
    }
    complete -F _ctlact ctlact
    ### End of ctlact block
fi

if command -v fwupdmgr &>/dev/null; then
    fwcheck() {
        sudo fwupdmgr refresh --force
        sudo fwupdmgr get-updates
    }
fi

if command -v git &>/dev/null; then
    function dotfiles {
        git --git-dir="$HOME"/.dotfiles_git/ --work-tree="$HOME" "$@"
    }
    alias dot='dotfiles '
fi

installKubectl() {
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    if [[ $? == 0 ]]; then
        chmod +x kubectl
        mkdir -p ~/.local/bin
        mv ./kubectl ~/.local/bin/kubectl
    fi
}

if command -v docker &>/dev/null; then
    source <(docker completion "$theShell")
    watchtower() {
        docker login
        docker run -d \
            --name watchtower \
            -v "$HOME"/.docker/config.json:/config.json \
            -v /var/run/docker.sock:/var/run/docker.sock \
            containrrr/watchtower --interval 60
    }
fi

if [[ $(command -v remmina) ]]; then

    rdp() {
        [ "$1" ] && remmina -c rdp://"$1" &
    }
    vnc() {
        [ "$1" ] && remmina -c vnc://"$1" &
    }
fi

if [[ $(command -v flatpak) ]]; then

    if [[ $(flatpak list | grep -i com.visualstudio.code) ]]; then
        code() {
            flatpak run com.visualstudio.code "$1" &
        }
    fi

fi

if command -v curl &>/dev/null; then
    # Creditst to Jeremy "Jay" LaCroix
    # <https://www.learnlinux.tv/10-linux-terminal-tips-and-tricks-to-enhance-your-workflow/
    c() {
        # Ask cheat.sh website for details about a Linux command.
        curl -m 10 "http://cheat.sh/${1}" 2>/dev/null || printf '%s\n' "[ERROR] Something broke"
    }
    wth() {
        curl -m 10 "https://wttr.in/${1}" 2>/dev/null || printf '%s\n' "[ERROR] Something broke"
    }
fi

# This script defines a function named `checkSum` that can be used to verify the
# checksum of a file using a specified algorithm. The function takes three arguments:
# the algorithm to use (md5, sha1, sha256, or sha512), the file to check, and the
# expected checksum value. The function calculates the checksum of the given file
# using the specified algorithm and compares it to the expected value. If the calculated
# and expected values match, it prints a message indicating that the checksum is OK;
# otherwise, it prints a message indicating that the checksum is not OK.
#
# Usage: checkSum [md5|sha1|sha256|sha512] [file] [sum]
#
# Example: checkSum md5 myfile.txt d41d8cd98f00b204e9800998ecf8427e

checkSum() {
    if [ "$1" = "--help" ]; then
        echo "Usage: checkSum [md5|sha1|sha256|sha512] [file] [sum]"
        return 0
    fi

    if [ "$#" -ne 3 ]; then
        echo "Error: Invalid number of arguments"
        echo "Usage: checkSum [md5|sha1|sha256|sha512] [file] [sum]"
        return 2
    fi

    local algorithm="$1"
    local file="$2"
    local expected_sum="$3"

    if ! [[ "$algorithm" =~ ^(md5|sha1|sha256|sha512)$ ]]; then
        echo "Error: Invalid algorithm"
        echo "Algorithm (first parameter) must be one of: md5, sha1, sha256, sha512"
        return 3
    fi

    if [ ! -f "$file" ]; then
        echo "Error: File not found"
        echo "File (second parameter) must be a valid file path"
        return 4
    fi

    local command="${algorithm}sum"
    if ! command -v "$command" &>/dev/null; then
        echo "Error: Command not found"
        echo "Command ${command} is not installed on this system"
        return 5
    fi

    local calculated_sum=$("$command" "$file" | cut -d ' ' -f 1)
    echo "Given: $expected_sum"
    echo "Calculated: $calculated_sum"

    if [ "$(echo "$calculated_sum" | tr '[:upper:]' '[:lower:]')" = "$(echo "$expected_sum" | tr '[:upper:]' '[:lower:]')" ]; then
        if [ "$calculated_sum" != "$expected_sum" ]; then
            echo "Warning: Case mismatch between given and calculated checksums"
        fi
        echo "${command} OK"
        return 0
    else
        echo "${command} NOT OK!!"
        return 1
    fi
}
if [ -n "$BASH_VERSION" ]; then
    # Bash completion function
    _checkSum() {
        local cur prev words cword
        _init_completion || return

        case $prev in
            checkSum)
                COMPREPLY=($(compgen -W "md5 sha1 sha256 sha512 --help" -- "$cur"))
                return 0
                ;;
        esac

        _filedir
    }

    complete -F _checkSum checkSum
elif [ -n "$ZSH_VERSION" ]; then
    # Zsh completion function
    #compdef checkSum

    _checkSum() {
        local curcontext="$curcontext" state line expl ret=1

        _arguments -C \
          '1: :->algorithm' \
          '2: :_files' \
          '*::arg:->args' && ret=0

        case $state in
          (algorithm)
              _wanted algorithm expl 'algorithm' compadd md5 sha1 sha256 sha512 --help && ret=0
              ;;
          (args)
              _message 'checksum value'
              ret=0
              ;;
          (*) 
              ret=1 
              ;;
        esac

        return ret
    }

    compdef _checkSum checkSum
fi
# End of checkSum block

getCharge() {
    local mode=$(sudo cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
    echo "Conservation mode: ${mode}"
}
stopCharge() {
    echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
}
startCharge() {
    echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
}

# Credits to Connor - https://stackoverflow.com/questions/24283097/reusing-output-from-last-command-in-bash
# Usage
# $ find . -name 'filename' | cap
# /path/to/filename
#
# $ ret
# /path/to/filename
# capture the output of a command so it can be retrieved with ret
cap() { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret() { cat /tmp/capture.out; }

#launch interception-tolls in background
interception() {
  sudo ln -sf /usr/lib64/libyaml-cpp.so.0.7.0 /usr/lib64/libyaml-cpp.so.0.6
  sudo /usr/bin/udevmon -c /etc/interception/udevmon.yaml &;
  sudo nice -n -20 udevmon
}

#Converts all .wav to .mp3 in the current git-dir
convertMp3Wav () {
  mkdir wav; for i in *.mp3; do ffmpeg -i "$i" "./wav/${i%.*}.wav"; done
}

fortibug () {
   echo "Try to connect to the VPN now"
  x=99
  while [ $x -ne 0 ]
  do
    echo "Waiting for VPN connection..."
    sleep 1
    connection=$(nmcli connection show | grep -oP '^vpn\S*')
    x=$?
  done

  echo "VPN connection $connection was created! Waiting for 'device-reapply'..."
  x=99
  while [ $x -ne 0 ]
  do
    nmcli -f GENERAL.STATE con show $connection 2> /dev/null
    x=${PIPESTATUS[0]}
    sleep 1
    echo "Still waiting..."
  done

  echo "Device is unmanaged. Setting it to 'up' again..."
  nmcli con up $connection 2> /dev/null
  echo "Done."
}

stopDaemons () {
  ctlsp cyservice.service sentinelone.service
}

### GRET SCRIPTS TO MOUNT SSHFS AND DINAMYCALLY CREATE AND DESTROY MOUNT POINTS
### WITH AUTOCOMPLETE!!! Credits: ChatGPT
# Define an empty array to store the attached servers
ATTACHED_SERVERS=()

# Define a function to add a server to the ATTACHED_SERVERS array
add_attached_server() {
    local server_name="$1"
    if ! [[ " ${ATTACHED_SERVERS[@]} " =~ " ${server_name} " ]]; then
        ATTACHED_SERVERS+=("$server_name")
    fi
}

# Define a function to remove a server from the ATTACHED_SERVERS array
remove_attached_server() {
    local server_name="$1"
    ATTACHED_SERVERS=("${ATTACHED_SERVERS[@]/$server_name}")
}

# Define a function to mount a remote directory using sshfs
sshmount() {
    # Set the server name, user, and port from the arguments
    SERVER_NAME="$1"
    SSH_USER="$2"
    SSH_PORT="$3"
    # Set the remote directory to mount
    REMOTE_DIR="/"
    # Set the local mount point
    MOUNT_POINT="$HOME/mnt/$SERVER_NAME"
    # Create the mount point if it does not exist
    if [ ! -d "$MOUNT_POINT" ]; then
        mkdir -p "$MOUNT_POINT"
    fi
    # Build the sshfs command with the specified user and port, if provided
    SSHFS_CMD="sshfs $SERVER_NAME:$REMOTE_DIR $MOUNT_POINT"
    if [ -n "$SSH_USER" ]; then
        SSHFS_CMD="$SSHFS_CMD -o User=$SSH_USER"
    fi
    if [ -n "$SSH_PORT" ]; then
        SSHFS_CMD="$SSHFS_CMD -o Port=$SSH_PORT"
    fi
    # Mount the remote directory using sshfs
    if eval $SSHFS_CMD; then
        # Add the server name to the ATTACHED_SERVERS array
        add_attached_server "$SERVER_NAME"
    fi
}

# Define a function to unmount a remote directory and remove the local mount point
sshumount() {
    # Set the server name from the first argument
    SERVER_NAME="$1"
    # Set the local mount point
    MOUNT_POINT="$HOME/mnt/$SERVER_NAME"
    # Unmount the remote directory using fusermount
    fusermount -u $MOUNT_POINT
    # Remove the local mount point directory
    rmdir $MOUNT_POINT
    # Remove the server name from the ATTACHED_SERVERS array
    remove_attached_server "$SERVER_NAME"
}

# Define a custom completion function for the sshmount and sshumount functions
_sshmount_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${ATTACHED_SERVERS[*]}" -- "$cur") )
}

# Register the custom completion function for the sshmount and sshumount functions
complete -F _sshmount_completion sshmount sshumount
### END OF SSHFS SCRIPTS BLOCK

# This function sets up a remote server for SSH access.
# It takes one required argument and two optional arguments: host, user (optional), and ssh_key_path (optional).
# - host: the hostname or IP address of the remote system
# - user (optional): the username on the remote system (defaults to the current local user)
# - ssh_key_path (optional): the path to your local SSH key (if not specified, the key will not be copied)
#
# The function performs the following operations:
# 1. Copies your local zsh configuration files and scripts to the remote server.
# 2. Installs zsh on the remote system if it is not already installed.
# 3. Sources your zsh user environment on the remote shell by adding a line to the remote .zshrc file.
# 4. If ssh_key_path is specified, copies your SSH key to the remote server to allow for passwordless login in the future, if it is not already present.
# 5. Opens an interactive zsh session on the remote server.
function sshenv() {
    if [[ $1 == "--help" || -z $1 ]]; then
        echo "Usage: sshenv host [user] [ssh_key_path]"
        echo "Sets up a remote server for SSH access."
        echo "  host: the hostname or IP address of the remote system"
        echo "  user (optional): the username on the remote system (defaults to the current local user)"
        echo "  ssh_key_path (optional): the path to your local SSH key (if not specified, the key will not be copied)"
        return
    fi

    host=$1
    user=${2:-$USER}
    ssh_key_path=$3

    # Set the ZDOTDIR variable
    source ~/.zshenv

    # Copy local zsh configuration files and scripts to remote server
    if [[ -n $ssh_key_path ]]; then
        rsync -avz -e "ssh -i $ssh_key_path" ~/.zshenv $ZDOTDIR $user@$host:~
    else
        rsync -avz ~/.zshenv $ZDOTDIR $user@$host:~
    fi

    # Install zsh if missing
    ssh $user@$host 'which zsh || (sudo apt-get update && sudo apt-get install -y zsh)'

    # Source zsh user environment
    ssh $user@$host 'echo "source ~/.zshenv" >> ~/.zshrc'

    # Copy ssh key to remote server if specified and not already present
    if [[ -n $ssh_key_path ]]; then
        ssh-keygen -y -f $ssh_key_path | ssh $user@$host "mkdir -p ~/.ssh; grep -q -F \"$(cat $ssh_key_path.pub)\" ~/.ssh/authorized_keys || cat >> ~/.ssh/authorized_keys"
    fi

    # SSH into remote server and start zsh shell
    ssh -t $user@$host zsh
}

# Profile backup script by ChatGPT
function backup_home() {
  # Check if a backup destination was provided
  if [ -z "$1" ]; then
    echo "Usage: backup_home BACKUP_DEST"
    return 1
  fi

  # Set the backup destination
  local BACKUP_DEST="$1"

  # Set the directories to exclude
  local EXCLUDE_DIRS=( "chrome" "edge" "onedrive" "onedriveFratelliCarli" ".var" ".cache" ".go")

  # Create the exclude options for the tar command
  local EXCLUDE_OPTS=()
  for dir in "${EXCLUDE_DIRS[@]}"; do
    EXCLUDE_OPTS+=("--exclude=${dir}")
  done

  # Create the backup
  echo "Starting backup..."
  tar "${EXCLUDE_OPTS[@]}" --checkpoint=.1000 --checkpoint-action=exec='printf "\r%4d MB written" $TAR_CHECKPOINT' -czf ${BACKUP_DEST}/home_backup.tar.gz ~/
  echo -e "\nBackup complete!"
}

# Update pip packages
pip_update() {
  pip --disable-pip-version-check list --outdated --format=json | python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" | xargs -n1 pip install -U
}