#!/bin/bash

# Define the username
USERNAME="carlos"

# Read the passwords from the file
PASSWORD_FILE="passwords.txt"
COOKIE_FILE="cookies.txt"
COOKIE_VALUES_FILE="cookie_values.txt"

# Check if the passwords file exists
if [[ ! -f "$PASSWORD_FILE" ]]; then
    echo "Password file not found: $PASSWORD_FILE"
    exit 1
fi

# Clear or create the output files
> "$COOKIE_FILE"
> "$COOKIE_VALUES_FILE"

# Read each password from the file and process it
while IFS= read -r PASSWORD; do
    # Compute MD5 hash of the password
    MD5_HASH=$(echo -n "$PASSWORD" | md5sum | awk '{print $1}')

    # Combine username and MD5 hashed password with ':'
    COMBINED_STRING="${USERNAME}:${MD5_HASH}"

    # Encode the combined string in Base64
    COOKIE=$(echo -n "$COMBINED_STRING" | base64)

    # Output the result and save only the cookie line
    echo "Cookie: $COOKIE" >> "$COOKIE_FILE"

done < "$PASSWORD_FILE"

# Extract only the cookie values using awk and save them to another file
awk '{print $2}' "$COOKIE_FILE" > "$COOKIE_VALUES_FILE"

echo "Cookies saved to $COOKIE_FILE"
echo "Cookie values saved to $COOKIE_VALUES_FILE"
