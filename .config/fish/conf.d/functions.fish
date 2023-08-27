#!/usr/bin/fish
# functions.fish

function fastping
    ping -c 100 -s 2
end

function chx
    chmod +x "$argv[1]"
end

function chxr
    chmod -R +x "$argv[1]"
end

function dush
    if test -n "$ZSH_VERSION"
        set -l nomatch
        du -hs "$argv[1]"/.[^.]* "$argv[1]"/*
        set +l nomatch
    else if test -n "$BASH_VERSION"
        if compgen -G "$argv[1]"/.[^.]* > /dev/null
            du -hs "$argv[1]"/.[^.]* "$argv[1]"/*
        else
            du -hs "$argv[1]"/*
        end
    else
        echo "Unsupported shell"
    end
end

function sudush
    if test -n "$ZSH_VERSION"
        set -l nomatch
        sudo du -hs "$argv[1]"/.[^.]* "$argv[1]"/*
        set +l nomatch
    else if test -n "$BASH_VERSION"
        if compgen -G "$argv[1]"/.[^.]* > /dev/null
            sudo du -hs "$argv[1]"/.[^.]* "$argv[1]"/*
        else
            sudo du -hs "$argv[1]"/*
        end
    else
        echo "Unsupported shell"
    end
end

function hg
    history | grep "$argv[1]"
end

function psa
    sudo ps -aux
end

if command systemctl > /dev/null
    # Basic systemctl commands
    
    # Start and then view status of service
    function ctlsts
        sudo systemctl start $argv[1]
        sudo systemctl status $argv[1]
    end
    
    # Restart and then view status of service
    function ctlrts
        sudo systemctl restart $argv[1]
        sudo systemctl status $argv[1]
    end
    
    # Stop and then view status of service
    function ctlsps
        sudo systemctl stop $argv[1]
        sudo systemctl status $argv[1]
    end
    
    # The ctlact function is a utility for managing systemd services.
    # It takes an action (start, stop, restart, or status) as the first argument,
    # and one or more service names as additional arguments.
    # The function performs the specified action on all the specified services,
    # and then displays their status.
    
    # Usage: ctlact ACTION SERVICE [SERVICE...]
    
    # Examples:
    #   ctlact restart apache2 nginx
    #   ctlact status sshd
    
    function ctlact 
      set action $argv[1]
      for service in $argv[2..-1]
          systemctl $action $service 
          systemctl status $service 
      end 
    end 
end 

if command fwupdmgr > /dev/null
    function fwcheck
        sudo fwupdmgr refresh --force
        sudo fwupdmgr get-updates
    end
end

if command git > /dev/null
    function dotfiles
        git --git-dir="$HOME"/.dotfiles_git/ --work-tree="$HOME" $argv
    end
end

function installKubectl
    curl -LO "https://dl.k8s.io/release/(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "(cat kubectl.sha256)  kubectl" | sha256sum --check
    if test $status = 0
        chmod +x kubectl
        mkdir -p ~/.local/bin
        mv ./kubectl ~/.local/bin/kubectl
    end
end

if command docker > /dev/null
    source (docker completion fish | psub)
    function watchtower
        docker login
        docker run -d \
            --name watchtower \
            -v "$HOME"/.docker/config.json:/config.json \
            -v /var/run/docker.sock:/var/run/docker.sock \
            containrrr/watchtower --interval 60
    end
end

# if command remmina > /dev/null 
#     function rdp 
#         if test -n "$argv[1]"; remmina -c rdp://"$argv[1]" &; end 
#     end 
#     function vnc 
#         if test -n "$argv[1]"; remmina -c vnc://"$argv[1]" &; end 
#     end 
# end 

if command flatpak > /dev/null 
    if flatpak list | grep -i com.visualstudio.code > /dev/null 
        function code 
            flatpak run com.visualstudio.code $argv[1] & 
        end 
    end 
end 

if command curl > /dev/null 
    # Creditst to Jeremy "Jay" LaCroix 
    # <https://www.learnlinux.tv/10-linux-terminal-tips-and-tricks-to-enhance-your-workflow/ 
    function c 
        # Ask cheat.sh website for details about a Linux command. 
        curl -m 10 "http://cheat.sh/$argv[1]" 2>/dev/null || printf '%s\n' "[ERROR] Something broke" 
    end 
    
    function wth 
        curl -m 10 "https://wttr.in/$argv[1]" 2>/dev/null || printf '%s\n' "[ERROR] Something broke" 
    end 
end 

function checkSum
    if test "$argv[1]" = "--help"
        echo "Usage: checkSum [md5|sha1|sha256|sha512] [file] [sum]"
        return 0
    end
    if test (count $argv) -ne 3
        echo "Error: Invalid number of arguments"
        echo "Usage: checkSum [md5|sha1|sha256|sha512] [file] [sum]"
        return 2
    end
    set algorithm $argv[1]
    set file $argv[2]
    set expected_sum $argv[3]
    if not string match -r '^(md5|sha1|sha256|sha512)$' $algorithm > /dev/null
        echo "Error: Invalid algorithm"
        echo "Algorithm (first parameter) must be one of: md5, sha1, sha256, sha512"
        return 3
    end
    if not test -f $file
        echo "Error: File not found"
        echo "File (second parameter) must be a valid file path"
        return 4
    end
    set command "$algorithm"sum
    if not command -v $command > /dev/null
        echo "Error: Command not found"
        echo "Command $command is not installed on this system"
        return 5
    end
    set calculated_sum ($command $file | cut -d ' ' -f 1)
    echo "Given: $expected_sum"
    echo "Calculated: $calculated_sum"
    if test (echo $calculated_sum | tr '[:upper:]' '[:lower:]') = (echo $expected_sum | tr '[:upper:]' '[:lower:]')
        if test $calculated_sum != $expected_sum
            echo "Warning: Case mismatch between given and calculated checksums"
        end
        echo "$command OK"
        return 0
    else
        echo "$command NOT OK!!"
        return 1
    end
end
# End of checkSum block

function getCharge
    set mode (sudo cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
    echo "Conservation mode: $mode"
end

function stopCharge
    echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
end

function startCharge
    echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
end

# capture the output of a command so it can be retrieved with ret
function cap
    tee /tmp/capture.out
end

# return the output of the most recent command that was captured by cap
function ret
    cat /tmp/capture.out
end

#launch interception-tolls in background
function interception
    sudo ln -sf /usr/lib64/libyaml-cpp.so.0.7.0 /usr/lib64/libyaml-cpp.so.0.6
    sudo /usr/bin/udevmon -c /etc/interception/udevmon.yaml &
    sudo nice -n -20 udevmon
end

#Converts all .wav to .mp3 in the current git-dir
function convertMp3Wav 
    mkdir wav; for i in *.mp3; ffmpeg -i $i ./wav/(string replace '.mp3' '.wav' $i); end 
end

function fortibug 
    echo "Try to connect to the VPN now"
    set x 99
    while test $x -ne 0 
        echo "Waiting for VPN connection..."
        sleep 1 
        set connection (nmcli connection show | grep -oP '^vpn\S*')
        set x $status 
    end 
    echo "VPN connection $connection was created! Waiting for 'device-reapply'..."
    set x 99 
    while test $x -ne 0 
        nmcli -f GENERAL.STATE con show $connection ^&1 > /dev/null 
        set x $status 
        sleep 1 
        echo "Still waiting..."
    end 
    echo "Device is unmanaged. Setting it to 'up' again..."
    nmcli con up $connection ^&1 > /dev/null 
    echo "Done."
end 

function stopDaemons 
    ctlsps cyservice.service sentinelone.service 
end 

# Define an empty array to store the attached servers
set ATTACHED_SERVERS

# Define a function to add a server to the ATTACHED_SERVERS array
function add_attached_server
    set server_name $argv[1]
    if not contains $server_name $ATTACHED_SERVERS
        set ATTACHED_SERVERS $server_name $ATTACHED_SERVERS
    end
end

# Define a function to remove a server from the ATTACHED_SERVERS array
function remove_attached_server
    set server_name $argv[1]
    set -e ATTACHED_SERVERS[(contains -i $server_name $ATTACHED_SERVERS)]
end

# Define a function to mount a remote directory using sshfs
function sshmount
    # Set the server name, user, and port from the arguments
    set SERVER_NAME $argv[1]
    set SSH_USER $argv[2]
    set SSH_PORT $argv[3]
    # Set the remote directory to mount
    set REMOTE_DIR "/"
    # Set the local mount point
    set MOUNT_POINT "$HOME/mnt/$SERVER_NAME"
    # Create the mount point if it does not exist
    if not test -d $MOUNT_POINT
        mkdir -p $MOUNT_POINT
    end
    # Build the sshfs command with the specified user and port, if provided
    set SSHFS_CMD "sshfs $SERVER_NAME:$REMOTE_DIR $MOUNT_POINT"
    if test -n "$SSH_USER"
        set SSHFS_CMD "$SSHFS_CMD -o User=$SSH_USER"
    end
    if test -n "$SSH_PORT"
        set SSHFS_CMD "$SSHFS_CMD -o Port=$SSH_PORT"
    end
    # Mount the remote directory using sshfs
    if eval $SSHFS_CMD
        # Add the server name to the ATTACHED_SERVERS array
        add_attached_server $SERVER_NAME
    end
end

# Define a function to unmount a remote directory and remove the local mount point
function sshumount 
    # Set the server name from the first argument 
    set SERVER_NAME $argv[1] 
    # Set the local mount point 
    set MOUNT_POINT "$HOME/mnt/$SERVER_NAME" 
    # Unmount the remote directory using fusermount 
    fusermount -u $MOUNT_POINT 
    # Remove the local mount point directory 
    rmdir $MOUNT_POINT 
    # Remove the server name from the ATTACHED_SERVERS array 
    remove_attached_server $SERVER_NAME 
end 

# Define a custom completion function for the sshmount and sshumount functions 
function _sshmount_completion 
  complete -c sshmount -c sshumount -xa "($ATTACHED_SERVERS)" 
end 

### END OF SSHFS SCRIPTS BLOCK

# Update pip packages
function pipue
    pip --disable-pip-version-check list --outdated --format=json | python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" | xargs -n1 pip install -U
end

function pipueu
    pip --disable-pip-version-check list --user --outdated --format=json | python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" | xargs -n1 pip install --user -U
end

function sync_xxh_config
    set origins $HOME/.config
    set destination $HOME/gitdepot/xxh-plugin-prerun-dotfiles/home
    set options "--archive --verbose --delete"
    set exclude_array "Microsoft*" "remmina"
    set exclude_string (printf " --exclude '%s'" $exclude_array)
    for origin in $origins
        echo $origin
        set exclusions (du -sh $origin/* | grep -E '[0-9]' | grep -Ev '(zsh|nvim)' | cut -d / -f5- | sed "s/^/--exclude '/;s/\$/'/" | /bin/tr '\n' ' ')
        set arguments "$options $exclusions $exclude_string $origin $destination"
        /bin/bash -c "rsync $arguments"
    end
    git -C $destination add $destination/.config
    git -C $destination commit  -m 'edit .config' 
    git -C $destination push origin HEAD:master 
end

function vmware_scan_new_disk
    for host in /sys/class/scsi_host/*
        echo "- - -" | sudo tee $host/scan
        ls /dev/sd*
    end
end

