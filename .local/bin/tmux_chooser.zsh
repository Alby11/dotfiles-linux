#!/usr/bin/env zsh

# Function to handle Ctrl-C interrupt
function ctrl_c() {
    echo -e "\rEnter 'nil' to drop to normal prompt"
    read -r input
    if [[ $input == 'nil' ]]; then
        exit 1
    fi
}

# Trap Ctrl-C signal and call ctrl_c function
trap ctrl_c SIGINT

# Get the list of tmux sessions with detailed information
output=()
while read -r line; do
    session_name=$(echo "$line" | awk -F: '{print $1}')
    session_info=$(tmux display-message -p -t "$session_name" '#{session_windows} windows, created at #{session_created}, attached: #{session_attached}')
    session_created=$(tmux display-message -p -t "$session_name" '#{session_created}')
    human_readable_time=$(date -d @"$session_created" '+%Y/%m/%d %H:%M:%S')
    output+=("$line")
    echo "$line"
    echo "${session_name}: ${session_info}, created at ${human_readable_time}"
    echo "----------------------------------------"
done < <(tmux list-sessions -F '#S: #I:#P #W [#F] #T #L')

no_of_terminals=${#output[@]}

# Display the list of tmux sessions
echo "Choose the terminal to attach: "
for i in {1..$no_of_terminals}; do
    echo "$i - ${output[i-1]}"
done

echo
echo "Create a new session by entering a name for it (timeout in 10 seconds)"

# Countdown timer in the background
(
    for ((i=10; i>0; i--)); do
        if (( i <= 5 )); then
            echo -ne "\e[31m$i seconds remaining...\e[0m\r"
        else
            echo -ne "$i seconds remaining...\r"
        fi
        sleep 1
    done
    echo
) &
countdown_pid=$!

# Read user input
read -t 10 -r input

# Kill the countdown process
kill $countdown_pid 2>/dev/null

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
