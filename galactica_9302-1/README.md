# 🔗 `galactica_9302-1 (Reticulum)`

![chain-id](https://img.shields.io/badge/chain%20id-galactica_9302--1-blue?style=for-the-badge)
![version: v0.1.2](https://img.shields.io/badge/version-v0.1.2-green?style=for-the-badge)


## Install [`galactica`](https://github.com/Galactica-corp/galactica)

To clone the networks repository, run:

```sh
git clone https://github.com/Galactica-corp/galactica
cd galactica
git checkout v0.1.2
make install
```

## How to become a validator

In order to become a validator, you need to have a node running and a minimum of `100 $GNET` delegated to your validator.
The testnet is running with the following parameters:
- Chain ID: `galactica_9302-1`
- EVM Chain ID: `9302`


First, you need to run a galactica node and create a key.

```sh
# Init node
galacticad init your-moniker --chain-id galactica_9302-1
```

Configure tendermint rpc to send transactions and query the blockchain:

```sh
galacticad config node tcp://seed01-reticulum.galactica.com:26657
```

You could use your own node or any other public node.

Then create a private key:

```sh
galacticad keys add your-key-name
```

Copy genesis.json from the repository to the config folder:

```sh
wget https://raw.githubusercontent.com/Galactica-corp/networks/main/galactica_9302-1/genesis.json -O ~/.galactica/config/genesis.json
```

Configure seed nodes in the `config.toml` file:

```sh
# download the seeds.txt file:
wget https://raw.githubusercontent.com/Galactica-corp/networks/main/galactica_9302-1/seeds.txt -O ~/.galactica/config/seeds.txt

# set seeds in the config.toml file
seeds=$(cat ~/.galactica/config/seeds.txt | tr '\n' ',' | sed 's/,$//')
sed -i '' "s/seeds = \"\"/seeds = \"$seeds\"/" ~/.galactica/config/config.toml
```

## Register validator

To register your validator node you need to submit a create-validator transaction with the following command:

```sh
# Create a validator (100 $GNET)
galacticad tx staking create-validator \
  --amount=100000000000000000000agnet \
  --pubkey=$(galacticad tendermint show-validator) \
  --moniker="your-moniker" \
  --details="your-details" \
  --identity="id-from-keybase" \
  --website="https://your-website" \
  --security-contact="your-email" \
  --chain-id=galactica_9302-1 \
  --commission-rate="0.05" \
  --commission-max-rate="0.1" \
  --commission-max-change-rate="0.02" \
  --min-self-delegation="1" \
  --gas="200000" \
  --gas-prices="10agnet" \
  --from=your-key-name
```

You could also delegate tokens to your validator:

```sh
# Delegate tokens (5 $GNET)  
galacticad tx staking delegate \
    $(galacticad keys show your-key-name --bech val -a) \
    5000000000000000000agnet \
    --gas="200000" \
    --gas-prices="10agnet" \
    --from=your-key-name
```

## Run a validator node

To run a validator node, you need to start the node with the following command:

```sh
# Start the node
galacticad start --chain-id=galactica_9302-1
```


## Useful commands


Show the wallet address:

```sh
# Show gala address:
galacticad keys show your-key-name -a
# Show ETH address:
galacticad keys convert-bech32-to-hex $(galacticad keys show your-key-name -a)
# Get validator address
galacticad keys show your-key-name --bech val -a
# Get consensus address
galacticad keys show your-key-name --bech cons -a
# Get validator public key
galacticad keys show your-key-name --bech val -p
# Get consensus public key
galacticad keys show your-key-name --bech cons -p
```

Export ethereum private key:

```sh
# Export ethereum private key in hex format
galacticad keys unsafe-export-eth-key your-key-name
```

Check the account balance:

```sh
# Check account balance
galacticad query bank balances $(galacticad keys show your-key-name -a)
```

