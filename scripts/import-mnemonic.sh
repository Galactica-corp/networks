#!/usr/bin/env bash

MNEMONIC=${MNEMONIC:-""}

source ./scripts/gala.sh

# welcome message
echo -e "Welcome to \e[32mGalactica Network\e[0m node private key import script"
echo -e "This script will create a new key for your \e[32mGalactica Network\e[0m node"
echo "You can provide the mnemonic phrase as an environment variable MNEMONIC"

key_name=$(moniker_from_config)
if [ -z "$key_name" ]; then
  read -p "Enter key name: " key_name
fi

echo "Key name: $key_name"

if is_gala_key_exists $key_name; then
  echo "Key $key_name already exists, showing key"
  gala_keys_show $key_name
else
  echo "Importing mnemonic for key $key_name"
  # please enter mnemonic phrase:
  if [ -z "$MNEMONIC" ]; then
    read -p "Enter mnemonic: " MNEMONIC
  fi

  echo "MNEMONIC: ${MNEMONIC}"

  echo $MNEMONIC | gala keys add \
      $key_name \
      --recover \
      --keyring-backend $KEYRING_BACKEND \
      --algo "eth_secp256k1" \
      --keyring-dir $GALACTICA_HOME
fi

