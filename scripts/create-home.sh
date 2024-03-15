#!/usr/bin/env bash

source ./scripts/gala.sh

echo -e "Welcome to \e[32mGalactica Network\e[0m node home creation script"
echo -e "This script will create a new home directory for your \e[32mGalactica Network\e[0m node"


# check if network path exists, if not, error out
if [ ! -d "$NETWORK_PATH" ]; then
  echo "Network path does not exist at $NETWORK_PATH"
  exit 1
fi

# check if main path folder not empty, if not, error out:
if [ "$(ls -A $GALACTICA_HOME)" ]; then
  echo "Home path $GALACTICA_HOME is not empty, please remove it first or set a different GALACTICA_HOME"
  exit 1
fi

# create main path folder if not exists
if [ ! -d "$GALACTICA_HOME/" ]; then
  mkdir -p "$GALACTICA_HOME/"
fi

# get chain_id from genesis.json:
CHAIN_ID=$(jq -r '.chain_id' "$NETWORK_PATH"/genesis.json)
echo "Chain ID: $CHAIN_ID"

# get default denom from genesis.json:
BASE_DENOM=$(jq -r '.app_state.staking.params.bond_denom' "$NETWORK_PATH"/genesis.json)

# enter moniker from the command line in interactive mode if not provided as an argument:
if [ -z "$1" ]; then
  read -p "Enter moniker (default: validator): " moniker
  moniker=${moniker:-"validator"}
else
  moniker=$1
fi

echo "Moniker: $moniker"

gala init \
    $moniker \
    --chain-id $CHAIN_ID \
    --default-denom $BASE_DENOM \
    --home $GALACTICA_HOME

# copy NETWORK_PATH to GALACTICA_HOME
cp -r "$NETWORK_PATH"/app.toml "$GALACTICA_HOME/config/app.toml"
cp -r "$NETWORK_PATH"/client.toml "$GALACTICA_HOME/config/client.toml"
cp -r "$NETWORK_PATH"/config.toml "$GALACTICA_HOME/config/config.toml"
cp -r "$NETWORK_PATH"/genesis.json "$GALACTICA_HOME/config/genesis.json"
cp -r "$NETWORK_PATH"/gentx "$GALACTICA_HOME/config/gentx"

sed -i '' 's/moniker = "validator"/moniker = "'$moniker'"/g'  "$GALACTICA_HOME/config/config.toml"
sed -i '' 's/moniker = "localtestnet"/moniker = "'$moniker'"/g'  "$GALACTICA_HOME/config/config.toml"

echo -e "\e[32mGalactica Network\e[0m node home path: $GALACTICA_HOME"
