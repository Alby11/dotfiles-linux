#!/usr/bin/env zsh
# File: $ZDOTDIR/functions/network_share_functions.zsh

# Mounting function
mount_network_share() {
  local OPTIND
  local opt
  local username=$(whoami)
  local domain
  local server
  local share
  local protocol="samba"
  local cifs_error_message="Mount failed. If you're seeing a:
    'user CIFS mounts not supported'
    error, this typically means that the mount.cifs program
    needs to be installed as setuid root. This can be done with
    'sudo chmod u+s /sbin/mount.cifs'.
    You can do this by adding a line like this to your sudoers file:
    username ALL=(root) NOPASSWD: /sbin/mount.cifs
    Please be aware of the security implications."


  while getopts ":u:d:s:r:p:h-:" opt; do
    if [[ $opt == "-" ]]; then
      case "${OPTARG}" in
        username)
          username="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
          ;;
        domain)
          domain="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
          ;;
        server)
          server="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
          ;;
        share)
          share="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
          ;;
        protocol)
          protocol="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
          ;;
        help)
          echo "Usage: mount_network_share -s [server] -r [share] -u [username] -d [domain] -p [protocol]"
          echo "Mounts a network share at the specified server."
          echo "Options:"
          echo "  -s, --server    Specifies the server to connect to."
          echo "  -r, --share     Specifies the remote share to mount."
          echo "  -u, --username  Specifies the username (default is current session's username)."
          echo "  -d, --domain    Specifies the domain (optional)."
          echo "  -p, --protocol  Specifies the protocol (default is samba, can also be nfs)."
          return 0
          ;;
        *)
          if [[ "$OPTERR" = 1 && "${optspec:0:1}" != ":" ]]; then
            echo "Unknown option --${OPTARG}" >&2
            return 1
          fi
      esac    
    else
      case "${opt}" in
        u)
          username=$OPTARG
          ;;
        d)
          domain=$OPTARG
          ;;
        s)
          server=$OPTARG
          ;;
        r)
          share=$OPTARG
          ;;
        p)
          protocol=$OPTARG
          ;;
        h)
          echo "Usage: mount_network_share -s [server] -r [share] -u [username] -d [domain] -p [protocol]"
          echo "Mounts a network share at the specified server."
          echo "Options:"
          echo "  -s, --server    Specifies the server to connect to."
          echo "  -r, --share     Specifies the remote share to mount."
          echo "  -u, --username  Specifies the username (default is current session's username)."
          echo "  -d, --domain    Specifies the domain (optional)."
          echo "  -p, --protocol  Specifies the protocol (default is samba, can also be nfs)."
          return 0
          ;;
        \?)
         echo "Invalid option: -$OPTARG" >&2
         return 1
         ;;
       :)
         echo "Option -$OPTARG requires an argument." >&2
         return 1
         ;;
      esac 
    fi 
 done

  if [[ -z $server ]] || [[ -z $share ]]; then
    echo "Server and share parameters are required."
    return 1
  fi

  local mountpoint="$HOME/mnt/$server"_"$share"
  echo $mountpoint
  if [[ ! -d $mountpoint ]]; then
    mkdir -p $mountpoint
  fi

  if [[ $protocol == "samba" ]]; then
    if [[ -n $domain ]]; then 
      # mount -t cifs //$server/$share $mountpoint -o username=$username,domain=$domain,password=$password || echo $cifs_error_message 
      /usr/sbin/mount.cifs //$server/$share $mountpoint -o user=$username,dom=$domain || echo $cifs_error_message && \
        sudo mount -t cifs //$server/$share $mountpoint -o username=$username,domain=$domain
    else 
      # mount -t cifs //$server/$share $mountpoint -o username=$username,password=$password || echo $cifs_error_message 
      mount.cifs //$server/$share $mountpoint -o user=$username,pass=$password || echo $cifs_error_message 
    fi 
  elif [[ $protocol == "nfs" ]]; then 
    mount -t nfs //$server/$share $mountpoint || echo "Mount failed. Please check your NFS settings and try again."
  else 
    echo "Invalid protocol. Please specify either 'samba' or 'nfs'."
    return 1 
  fi 
}

# Unmounting function
unmount_network_share() {
  local server_share=$1
  local mountpoint="$HOME/mnt/$server_share"

  if [[ ! -d $mountpoint ]]; then
    echo "Mount point does not exist."
    return 1
  fi

  sudo umount $mountpoint && rmdir $mountpoint
}

# Autocomplete function for mount_network_share
_mount_network_share() {
  local -a args

  args+=(
    '(-u --username)-u[username]: :_users'
    '(-u --username)--username[username]: :_users'
    '(-d --domain)-d[domain]: :_hosts'
    '(-d --domain)--domain[domain]: :_hosts'
    '(-s --server)-s[server]: :_hosts'
    '(-s --server)--server[server]: :_hosts'
    '(-r --share)-r[share]: :_directories'
    '(-r --share)--share[share]: :_directories'
    '(-p --protocol)-p[protocol]:((samba nfs))'
    '(-p --protocol)--protocol[protocol]:((samba nfs))'
  )

  _arguments -s -S $args
}

compdef _mount_network_share mount_network_share

# Autocomplete function for unmount_network_share
_unmount_network_share() {
   _path_files -W $HOME/mnt -/
}

compdef _unmount_network_share unmount_network_share
