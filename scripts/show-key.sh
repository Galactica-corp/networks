#!/usr/bin/env bash

source ./scripts/gala.sh

# welcome message
echo -e "Welcome to \e[32mGalactica Network\e[0m node private key show script"
echo -e "This script will show an existing key for your \e[32mGalactica Network\e[0m node"

key_name=$(moniker_from_config)
if [ -z "$key_name" ]; then
  read -p "Enter key name: " key_name
fi

echo "Key name: $key_name"

#if is_gala_key_exists $key_name; then
if ! is_gala_key_exists $key_name; then
  echo "Key \"$key_name\" does not exist"
  exit 1
fi

echo "Key \"$key_name\" already exists, showing key"
echo "============================================="
echo "Key name: $key_name"
echo "Address: $(gala_keys_show $key_name)"
echo "Validator address: $(gala_keys show $key_name --bech val -a)"
echo "ETH address: $(gala keys convert-bech32-to-hex `gala_keys show $key_name -a`)"

if [ -z "$1" ]; then
  read -p "Do you want to export the private key? (yes/no): " export_key
else
  export_key=$1
fi

if [ "$export_key" == "yes" ]; then
  gala_keys unsafe-export-eth-key $key_name
fi
