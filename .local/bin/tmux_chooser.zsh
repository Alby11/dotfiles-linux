#!/usr/bin/env zsh
# shellcheck disable=SC2207

# Doesn't let you press Ctrl-C
function ctrl_c() {
    echo -e "\renter nil to drop to normal prompt"
    read -r input
    if [[ $input == 'nil' ]]; then
        exit 1
    fi
}

trap ctrl_c SIGINT

# Get the list of tmux sessions
output=($(tmux list-sessions -F '#S'))
no_of_terminals=${#output[@]}

echo "Choose the terminal to attach: "
for i in {1..$no_of_terminals}; do
    echo "$i - ${output[i-1]}"
done

echo
echo "Create a new session by entering a name for it"
read -r input

if [[ -z $input ]]; then
    tmux new-session
elif [[ $input == 'nil' ]]; then
    exit 1
elif [[ $input =~ ^[0-9]+$ ]] && (( input > 0 && input <= no_of_terminals )); then
    tmux attach -t "${output[input - 1]}"
else
    tmux new-session -s "$input"
fi

exit 0
