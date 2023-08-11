#!/usr/bin/env bash

# Check if the FILENAME argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 FILENAME"
    exit 1
fi

FILENAME=$1

# Read the ROOT_TOKEN from STDIN
if ! read -r -s -p "Enter Vault root token: " ROOT_TOKEN; then
  echo "Error: Failed to read ROOT_TOKEN from STDIN."
  exit 1
fi

echo # Print an empty line

# Run the vault write command and store the output in a variable
VAULT_OUTPUT=$(VAULT_TOKEN=$ROOT_TOKEN vault write -format=json transit/decrypt/database_backup ciphertext="$(cat "$FILENAME".key)")

# Extract the value from the output (plaintext)
KEY=$(echo "$VAULT_OUTPUT" | sed -nE 's/.*"plaintext": "([^"]+)".*/\1/p')

# Check if KEY is empty (error in vault write command or incorrect input file)
if [ -z "$KEY" ]; then
    echo "Error: Failed to retrieve decryption key from Vault."
    exit 1
fi

# Decrypt the file using the extracted KEY
cat "$FILENAME"*.enc | openssl enc -d -aes-256-cbc -pbkdf2 -k "$KEY" | gunzip > "$FILENAME".sql

echo "Decryption completed. Decrypted file saved as $FILENAME.sql"
