#!/usr/bin/env bash

# Run 'vault list auth/token/accessors' and store the result in a variable, skipping the first two lines
accessor_list=$(vault list auth/token/accessors | tail -n +3)

# Check if the list is empty
if [ -z "$accessor_list" ]; then
  echo "No accessors found."
  exit 1
fi

# Loop through each accessor and run 'vault token lookup'
while read -r accessor; do
  output=$(vault token lookup -accessor "$accessor")
  if [[ $output =~ token ]]; then
    echo "Token lookup for accessor $accessor:"
    echo "$output"
  fi
done <<< "$accessor_list"
