#!/usr/bin/env bash

source ./scripts/gala.sh

echo -e "Welcome to \e[32mGalactica Network\e[0m gentx creation script"
echo -e "This script will create a new gentx for your \e[32mGalactica Network\e[0m validator node"

gala validate-genesis

# show all keys:
echo "Available keys:"
echo "============================================="
gala_keys list
echo "============================================="

moniker=$(moniker_from_config)
echo "Moniker: $moniker"

# enter staking amount from the command line in interactive mode if not provided as an argument:
if [ -z "$2" ]; then
  read -p "Enter staking amount (GNET) ex. 100: " staking_amount
else
  staking_amount=$2
fi

if [ -z "$staking_amount" ]; then
  echo "Staking amount is required"
  exit 1
fi

# add 18 zeros to the staking amount:
staking_amount=$staking_amount"000000000000000000agnet"
echo "Staking amount: $staking_amount"

# enter ip from the command line in interactive mode if not provided as an argument:
if [ -z "$3" ]; then
  read -p "Enter validator node IP: " ip
else
  ip=$3
fi

if [ -z "$ip" ]; then
  echo "IP is required"
  exit 1
fi

echo "IP: $ip"

# enter p2p port from the command line in interactive mode if not provided as an argument:
if [ -z "$4" ]; then
  read -p "Enter p2p port (default 26656): " p2p_port
else
  p2p_port=$4
fi

p2p_port=${p2p_port:-"26656"}
echo "P2P port: $p2p_port"

echo "Please validate the above information before proceeding"
read -p "Press [enter] to continue"

gala gentx \
    $moniker \
    $staking_amount \
    --ip $ip \
    --p2p-port $p2p_port \
    --home $GALACTICA_HOME \
    --keyring-dir $GALACTICA_HOME \
    --keyring-backend $KEYRING_BACKEND

# get first newest created gentx-*.json file from $GALACTICA_HOME/config/gentx/:
gentx_file=$(ls -t $GALACTICA_HOME/config/gentx/ | head -n1)

echo "Moving $gentx_file to $NETWORK_PATH/gentx/"
cp $GALACTICA_HOME/config/gentx/$gentx_file $NETWORK_PATH/gentx/
echo "Done"
