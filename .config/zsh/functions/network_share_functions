#!/usr/bin/env zsh

function mount_network_share() {
    if [[ $1 == "-h" ]]; then
        echo "Usage: mount_network_share -s [server] -r [share] -u [username] -d [domain] -p [protocol]"
        echo "Mounts a network share at the specified server."
        echo "Options:"
        echo "  -s    Specifies the server to connect to."
        echo "  -r    Specifies the remote share to mount."
        echo "  -u    Specifies the username (default is current session's username)."
        echo "  -d    Specifies the domain (optional)."
        echo "  -p    Specifies the protocol (default is samba, can also be nfs)."
        return
    fi

    local OPTIND opt server share username domain protocol
    while getopts "s:r:u:d:p:" opt; do
      case $opt in
        s) server="$OPTARG" ;;
        r) share="$OPTARG" ;;
        u) username="$OPTARG" ;;
        d) domain="$OPTARG" ;;
        p) protocol="$OPTARG" ;;
      esac
    done

    username=${username:-$USER}
    protocol=${protocol:-cifs}

    if [[ -n $server && -n $share ]]; then
        # Create a mount point named as "server_share"
        local mount_point="/home/$USER/mnt/${server}_${share}"
        mkdir -p "$mount_point"
        
        if [[ $protocol == "samba" || $protocol == "cifs" ]]; then
            if [[ -n $domain ]]; then
                sudo mount -t cifs "//$server/$share" "$mount_point" -o username=$username,domain=$domain
            else
                sudo mount -t cifs "//$server/$share" "$mount_point" -o username=$username
            fi
        elif [[ $protocol == "nfs" ]]; then
            sudo mount -t nfs "$server:$share" "$mount_point"
        fi

        if [[ $? -ne 0 ]]; then
            rmdir "$mount_point"
        fi
    else
        echo "Usage: mount_network_share -s [server] -r [share] -u [username] -d [domain] -p [protocol]"
    fi
}

function unmount_share() {
    if [[ $1 == "-h" ]]; then
        echo "Usage: unmount_share"
        echo "Unmounts a previously mounted network share."
        return
    fi

    local mount_point
    # local FZF_DEFAULT_OPTS_SAVE=$FZF_DEFAULT_OPTS
    # FZF_DEFAULT_OPTS="--color=bw"
    # mount_point=$(/usr/bin/ls /home/$USER/mnt | fzf --no-color)
    mount_point=$(/usr/bin/ls /home/$USER/mnt)
    # FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS_SAVE
    # unset $FZF_DEFAULT_OPTS_SAVE
    if [[ -n $mount_point ]]; then
        sudo umount "/home/$USER/mnt/$mount_point" && rmdir "/home/$USER/mnt/$mount_point"
    fi
}

# Autocomplete function for protocols in mount_network_share function.
function _mount_network_share() {
  local cur prev opts base
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  # Autocomplete for protocols.
  if [[ ${prev} == "-p" ]] ; then
      COMPREPLY=( $(compgen -W 'cifs nfs' -- ${cur}) )
      return 0
  fi

  # Default autocomplete.
  COMPREPLY=( $(compgen -F _mount_network_share -- ${cur}) )
  return 0
}
complete -F _mount_network_share mount_network_share

# Autocomplete function for unmount_share function.
function _unmount_share() {
  local cur prev opts base dir_list
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  
  # Autocomplete for directories in /home/user/mnt.
  dir_list=$(ls /home/$USER/mnt)
  COMPREPLY=( $(compgen -W "${dir_list}" -- ${cur}) )
  
  return 0
}
complete -F _unmount_share unmount_share

