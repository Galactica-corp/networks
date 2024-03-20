#!/usr/bin/env bash

GALACTICA_HOME="~/.galactica"
GALACTICA_HOME=$(eval echo $GALACTICA_HOME)
NETWORK_PATH=${NETWORK_PATH:-"./network/testnet/galactica_9301-1"}
KEYRING_BACKEND=${KEYRING_BACKEND:-"file"}
MONIKER=${MONIKER:-""}

function gala() {
    /usr/local/bin/galacticad --home "$GALACTICA_HOME" "$@"
}


function gala_keys_nopwd {
  gala keys "$@" --keyring-dir $GALACTICA_HOME --keyring-backend $KEYRING_BACKEND
}

function gala_keys {
  # check .password file. If it exists, use it content and pass it to gala command
  local password_file=".password"
  if [ -f "$password_file" ]; then
    local password=$(cat "$password_file")
    echo $password | gala keys "$@" --keyring-dir $GALACTICA_HOME --keyring-backend $KEYRING_BACKEND
  else
    gala_keys_nopwd "$@"
  fi
}

function is_gala_key_exists {
  # check if key file exists, if not, return error message
  if [ ! -f "$GALACTICA_HOME"/keyring-*/"$1".info ]; then
    echo "Key $1 does not exist"
    return 1
  fi
}

function gala_keys_show {
  is_gala_key_exists $1 && gala_keys show $1 -a
}

function moniker_from_config() {
  config_path="$GALACTICA_HOME/config/config.toml"
  if [ -f "$config_path" ]; then
    moniker=$(grep 'moniker' "$config_path" | awk -F '"' '{print $2}')
    echo $moniker
  fi
}

function moniker_from_keys() {
  # return first line from keys list:
  gala_keys list --list-names | head -n 1
}

function read_input {
  local prompt=$1
  local default_value=$2
  read -p "$prompt (default $default_value): " input
  echo ${input:-$default_value}
}

echo -e "============================================="
echo -e "Gala CLI version: $(gala version)"
echo -e "============================================="
echo -e "GALACTICA_HOME: $GALACTICA_HOME"
echo -e "NETWORK_PATH: $NETWORK_PATH"
echo -e "KEYRING_BACKEND: $KEYRING_BACKEND"
echo -e "============================================="
