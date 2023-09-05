#!/bin/bash

# Function to manage ssh sessions, configurations, and keys
ssh_manager() {
    # Prompt for key type
    echo "Enter the key type (rsa, dsa, ecdsa, ed25519) [ed25519]: "
    read keytype
    keytype=${keytype:-ed25519}

    # Prompt for remote server address and username
    echo "Enter the remote server address: "
    read remoteaddr
    echo "Enter the remote username: "
    read remoteuser

    # Create a new ssh key
    echo "Creating a new ssh key..."
    ssh-keygen -t $keytype -f ~/.ssh/id_${keytype}_${remoteaddr}_${remoteuser}
    echo "Key created successfully"

    # Copy the ssh key to the remote server
    echo "Copying the ssh key to the remote server..."
    ssh-copy-id -i ~/.ssh/id_${keytype}_${remoteaddr}_${remoteuser} $remoteuser@$remoteaddr
    echo "Key copied successfully"

    # Add a new entry to the ssh config file
    echo "Adding a new entry to the ssh config file..."
    echo "Enter the name for this config entry: "
    read entryname

    echo "" >> ~/.ssh/config
    echo "Host $entryname" >> ~/.ssh/config
    echo "  HostName $remoteaddr" >> ~/.ssh/config
    echo "  User $remoteuser" >> ~/.ssh/config
    echo "  IdentityFile ~/.ssh/id_${keytype}_${remoteaddr}_${remoteuser}" >> ~/.ssh/config

    echo "Config added successfully"

	# Check if user is already present in sudoers file
	sudoer_check=$(ssh $remoteuser@$remoteaddr "sudo grep -w '$username' /etc/sudoers")
	if [ -z "$sudoer_check" ]; then
		echo "Should the user be able to use sudo without a password? (y/n): "
		read without_password

		if [ "$without_password" == "y" ]; then
			ssh $remoteuser@$remoteaddr "echo '$username ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
			else
			ssh $remoteuser@$remoteaddr "echo '$username ALL=(ALL) ALL' | sudo tee -a /etc/sudoers"
			fi

			echo "User added to sudoers successfully"
	else 
		echo "$username is already present in sudoers file"
	fi 
}

# Run the ssh_manager function
ssh_manager
