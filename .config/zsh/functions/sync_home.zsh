#!/bin/zsh

sync_home() {
  usage() {
    echo "Usage: sync_home [options]"
    echo "Options:"
    echo "  --help, -h: Display this help message"
    echo "  --ssh-server[=]SERVER, -s[=]SERVER: Specify an SSH server to synchronize with"
  }
  local origins=("$HOME/.config" "$HOME/.local/bin" "$HOME/.zshenv")
  local destinations=("$HOME/gitdepot/xxh-plugin-prerun-dotfiles/home")
  local repositories=("$HOME/gitdepot/xxh-plugin-prerun-dotfiles")
  local options="--archive --verbose --delete"
  local exclude_array=("FortiClient" ".git" ".gitignore" ".gitmodules" ".gitattributes" "Microsoft*" "rabbitvcs" "remmina" ".ssh" )
  local exclude_string=$(printf " --exclude '%s'" "${exclude_array[@]}")
  # Add ssh servers as parameters and set destination to '/home/tallonea/.xxh' for ssh servers
  while [ $# -gt 0 ]; do
    case "$1" in
      --ssh-server=*|-s=*|)
        local ssh_server="${1#*=}"
        return
        if [[ ! "$(ssh $(whoami)@$ssh_server grep $username /etc/passwd)" ]]; then
            echo "User $username does not exist on $ssh_server. Aborting..."
            exit 1
        fi
        destinations+=("$ssh_server:/home/tallonea")
        shift
        ;;
      --ssh-server|-s)
      shift
      local ssh_server="$1"
      destinations+=("$ssh_server:/home/tallonea")
      shift
      ;;
      --xxh-server=*|-x=*|)
        local ssh_server="${1#*=}"
        destinations+=("$ssh_server:/home/tallonea/.xxh")
        shift
        ;;
      --xxh-server|-x)
      shift
      local ssh_server="$1"
      destinations+=("$ssh_server:/home/tallonea/.xxh")
      shift
      ;;
      --help|-h)
        usage
        shift
        ;;
      *)
        printf "Error: Invalid argument\n"
        return 1
        ;;
    esac
  done

  if [[ ${#destinations[@]} -le 1 ]]; then
    echo "Error: You must specify at least one destination using --ssh-server or --xxh-server options"
    exit 1
  fi

  for origin in $origins
  do
    local exclusions=$(/bin/du -sh ${origin}/* | /bin/grep -E '0-9' | /bin/grep -Ev '(zsh|nvim|\.git[a-z]*$)' | /bin/cut -d / -f5- | /bin/sed "s/^/--exclude '/;s/$/'/" | /bin/tr '\n' ' ')
    echo $exclusions
    for destination in $destinations
    do
      echo -e "\n### ORIGIN: $origin ###" LOLCAT
      echo -e "### DESTINATION: $destination ###\n" LOLCAT
      local arguments="$options $exclusions $exclude_string $origin $destination"
      echo $arguments
      /bin/bash -c "rsync $arguments"
    done
  done
  for repository in $repositories
  do
    git -C $repository status
    git -C $repository add --update
    git -C $repository add $repository/.
    git -C $repository commit  --message 'edit home files' 
    git -C $repository push
    git -C $repository status
  done
}
