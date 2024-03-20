#!/usr/bin/env bash

source ./scripts/gala.sh

# welcome message
echo -e "Welcome to \e[32mGalactica Network\e[0m node private key creation script"
echo -e "This script will create a new key for your \e[32mGalactica Network\e[0m node"

key_name=$(moniker_from_config)
if [ -z "$key_name" ]; then
  read -p "Enter key name: " key_name
fi

echo "Key name: $key_name"

if is_gala_key_exists $key_name; then
  echo "Key \"$key_name\" already exists, showing key"
  gala_keys_show $key_name
else
  echo "Creating key \"$key_name\""
  gala_keys_nopwd add $key_name --algo eth_secp256k1
  echo "Showing key \"$key_name\""
  gala_keys_show $key_name
fi
