#!/usr/bin/env bash

source ./scripts/gala.sh

echo -e "Welcome to \e[32mGalactica Network\e[0m seeds update script"
echo -e "This script will update the seeds in config.toml"

SEEDS=`cat $NETWORK_PATH/seeds.txt | awk '{print $1}' | paste -s -d, -`
sed -i.bak -e "s/^seeds =.*/seeds = \"$SEEDS\"/" $GALACTICA_HOME/config/config.toml

echo "Seeds successfully updated in $GALACTICA_HOME/config/config.toml config file"
echo "Seeds:"
echo $SEEDS
