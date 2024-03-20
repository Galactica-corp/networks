#!/usr/bin/env bash

source ./scripts/gala.sh

echo -e "Welcome to \e[32mGalactica Network\e[0m gentx creation script"
echo -e "This script will create a new gentx for your \e[32mGalactica Network\e[0m validator node"

gala validate-genesis || { echo "Failed to validate genesis"; exit 1; }

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
  while true; do
    read -p "Enter validator node IP: " ip
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      break
    else
      echo "Invalid IP. Please try again."
    fi
  done
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

commission_rate=0.1
commission_max_rate=0.2
commission_max_change_rate=0.01

echo "Commission rate is the percentage of the reward that the validator will take as a commission."
commission_rate=$(read_input "Enter commission rate" $commission_rate)
printf "Commission rate: %.4f\n" $commission_rate

echo "---"

echo "Commission max rate is the maximum commission rate that the validator can set."
commission_max_rate=$(read_input "Enter commission max rate" $commission_max_rate)
printf "Commission max rate: %.4f\n" $commission_max_rate

echo "---"

echo "Commission max change rate is the maximum rate at which the validator commission can change."
commission_max_change_rate=$(read_input "Enter commission max change rate" $commission_max_change_rate)
printf "Commission max change rate: %.4f\n" $commission_max_change_rate

echo "---"

echo "Details is a description of the validator. (optional)"
read -p "Enter details: " details

echo "---"

echo "Security contact is a contact email for the validator. (optional)"
read -p "Enter security contact: " security_contact

echo "---"

echo "Website is a website for the validator. (optional)"
read -p "Enter website: " website

echo "---"

echo "Identity is a unique identifier for the validator. (optional)"
read -p "Enter identity: " identity

echo "---"

echo "Commission rate: $commission_rate"
echo "Commission max rate: $commission_max_rate"
echo "Commission max change rate: $commission_max_change_rate"
echo "Details: $details"
echo "Security contact: $security_contact"
echo "Website: $website"
echo "Identity: $identity"

echo "---"

echo "Please validate the above information before proceeding"
read -p "Press [enter] to continue"

gala add-genesis-account \
      "$(gala_keys show $moniker -a)" \
      $staking_amount

gala gentx \
    $moniker \
    $staking_amount \
    --amount $staking_amount \
    --ip $ip \
    --p2p-port $p2p_port \
    --commission-max-change-rate $commission_max_change_rate \
    --commission-max-rate $commission_max_rate \
    --commission-rate $commission_rate \
    --details "$details" \
    --security-contact "$security_contact" \
    --website "$website" \
    --identity "$identity" \
    --keyring-dir $GALACTICA_HOME \
    --keyring-backend $KEYRING_BACKEND \
    --chain-id=$(jq -r '.chain_id' "$NETWORK_PATH"/genesis.json) \
    --home $GALACTICA_HOME

# get first newest created gentx-*.json file from $GALACTICA_HOME/config/gentx/:
gentx_file=$(ls -t $GALACTICA_HOME/config/gentx/ | head -n1)

echo "Moving $gentx_file to $NETWORK_PATH/gentx/"
cp $GALACTICA_HOME/config/gentx/$gentx_file $NETWORK_PATH/gentx/
echo "Done"
