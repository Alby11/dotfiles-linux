#!/usr/bin/env zsh
# shellcheck disable=SC2207

# Function to handle Ctrl-C interrupt
function ctrl_c() {
    echo -e "\renter nil to drop to normal prompt"
    read -r input
    if [[ $input == 'nil' ]]; then
        exit 1
    fi
}

# Trap Ctrl-C signal and call ctrl_c function
trap ctrl_c SIGINT

# Get the list of tmux sessions
output=($(tmux list-sessions -F '#S'))
no_of_terminals=${#output[@]}

# Display the list of tmux sessions
echo "Choose the terminal to attach: "
for i in {1..$no_of_terminals}; do
    echo "$i - ${output[i-1]}"
done

echo
echo "Create a new session by entering a name for it (timeout in 10 seconds)"
read -t 10 -r input

# Handle user input
if [[ -z $input ]]; then
    # No input, create a new tmux session
    tmux new-session
elif [[ $input == 'nil' ]]; then
    # Input is 'nil', exit the script
    exit 1
elif [[ $input =~ ^[0-9]+$ ]] && (( input > 0 && input <= no_of_terminals )); then
    # Input is a valid number, attach to the selected tmux session
    tmux attach -t "${output[input - 1]}"
else
    # Input is a name, create a new tmux session with the given name
    tmux new-session -s "$input"
fi

exit 0
