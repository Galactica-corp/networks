# Galactica Networks

This repository hosts the genesis configurations for the Galactica networks.

For detailed guidance on setting up and running a Galactica network node, please visit the [Galactica repository](https://github.com/Galactica-corp/galactica).

## Networks Overview

| Name                 | Chain ID         | Environment | Configs                                                |
|----------------------|------------------|-------------|--------------------------------------------------------|
| galactica-testnet-v1 | galactica_9301-1 | testnet     | [galactica_9301-1](./network/testnet/galactica_9301-1) |

## Cloning the networks repository

To clone the networks repository, run:

```sh
git clone https://github.com/Galactica-corp/networks.git
cd networks
```


## Using the Scripts

The scripts in the `scripts` directory simplify the setup and management of your Galactica Network node. Here's a quick guide:

### Prerequisites

- Install `jq` for JSON processing.
- Set `GALACTICA_HOME` to your node's home directory, e.g., `export GALACTICA_HOME=~/.galactica`.
- Set `NETWORK_PATH` to your network configuration directory, e.g., `export NETWORK_PATH=./network/testnet/galactica_9301-1`.
- Set `KEYRING_BACKEND` to your keyring backend, e.g., `export KEYRING_BACKEND=test`. You can use various keyring backends such as `os`, `file`, `test`, `kwallet`, `pass`, etc. To read more about keyring backends, visit [Evmos documentation](https://docs.evmos.org/protocol/concepts/keyring#keyring-backends)
- Ensure the `galacticad` command-line tool is installed and accessible.

```sh
export GALACTICA_HOME=~/.galactica
export CHAIN_ID=galactica_9301-1
export NETWORK_PATH=./network/testnet/$CHAIN_ID
export KEYRING_BACKEND=file
```

### Scripts Overview

- **create-key.sh**: Creates a new private key for node security and transactions.
  ```bash
  ./scripts/create-key.sh
  ```
  Enter a key name when prompted. If the key exists, it will be displayed; otherwise, a new key is created.


- **create-home.sh**: Initializes the node's home directory with necessary configuration files. You can specify a custom home directory with the `GALACTICA_HOME` environment variable. This environment variable uses in all scripts.
  ```bash
  ./scripts/create-home.sh
  ```
  Enter a moniker and seed passphrase when prompted. The script will create a new home directory with provided moniker and private key.


- **create-tx.sh**: Generates a new genesis transaction (gentx) for registering your validator node.
  ```bash
  ./scripts/create-tx.sh
  ```
  Follow the prompts to input staking amount, validator node IP, and P2P port, etc. The script will generate a new gentx file in the `./network/testnet/galactica_9301-1/gentx` directory.


- **update-home.sh**: Updates the node's home directory with the latest configuration files.
  ```bash
  ./scripts/update-home.sh
  ```

- **show-key.sh**: Displays the node's private key.
  ```bash
  ./scripts/show-key.sh
  ```
    The script will display the public addresses in different formats and the private key if prompted.

- **import-mnemonic.sh**: Imports a mnemonic phrase into the keyring.
  ```bash
  ./scripts/import-mnemonic.sh
  ```
  Enter a mnemonic phrase when prompted. The script will import the mnemonic phrase into the keyring.

### Final Steps

After generating your gentx, submit it as public pull request to the [Galactica networks repository](https://github.com/Galactica-corp/networks). Ensure all information is accurate before proceeding.




## Alternative way to use the `galacticad` command-line tool

The `galacticad` command-line tool can be called directly without using the scripts. 

### Prerequisites

Please ensure the following environment variables are set:
```bash
export MONIKER="my-node"
export GALACTICA_HOME=~/.galactica
export CHAIN_ID=galactica_9301-1
export NETWORK_PATH=./network/testnet/$CHAIN_ID
export KEYRING_BACKEND=file
```

### Key Management

Galactica uses the `keyring` to manage keys. The `keyring` is a secure storage for keys and supports various backends such as `os`, `file`, `test`, `kwallet`, `pass`, etc. To read more about keyring backends, visit [Evmos documentation](https://docs.evmos.org/protocol/concepts/keyring#keyring-backends).

You can use the `galacticad keys` command to manage keys. Here are some examples:

#### Create a new key

Generate a new private key for node security and transactions. 

```bash
galacticad keys add $MONIKER \
  --home $GALACTICA_HOME \
  --keyring-dir $GALACTICA_HOME \
  --keyring-backend $KEYRING_BACKEND \
  --algo eth_secp256k1
```

On this step, you will be prompted to enter a passphrase to encrypt the key. Write down the mnemonic phrase and keep it safe. It is the only way to recover your key.

#### Show the key

Address and public key can be displayed using the following command:

```bash
galacticad keys show $MONIKER \
  --home $GALACTICA_HOME \
  --keyring-dir $GALACTICA_HOME \
  --keyring-backend $KEYRING_BACKEND
```

#### Import a mnemonic phrase

Import a mnemonic phrase into the keyring. You can add --recover flag to recover the key from the mnemonic phrase.

```bash 
galacticad keys add $MONIKER \
  --home $GALACTICA_HOME \
  --keyring-dir $GALACTICA_HOME \
  --keyring-backend $KEYRING_BACKEND \
  --recover
```

### Home Directory Management

#### Prerequisites

For the following commands, ensure the following environment variables are set:

```bash
export CHAIN_ID=galactica_9301-1
export NETWORK_PATH=./network/testnet/$CHAIN_ID
export BASE_DENOM=agnet
```

#### Initialize the home directory

Initialize the node's home directory with necessary configuration files.

```bash
galacticad init $MONIKER --recover \
  --home "$GALACTICA_HOME" \
  --chain-id $CHAIN_ID \
  --default-denom $BASE_DENOM \
  --keyring-backend $KEYRING_BACKEND
```

#### Copy the network configuration files

Copy the network configuration files to the home directory.

```bash
# copy NETWORK_PATH to GALACTICA_HOME
cp -r "$NETWORK_PATH"/{app.toml,client.toml,config.toml,genesis.json,gentx} "$GALACTICA_HOME/config/"

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
    sed -i '' 's/moniker = "validator"/moniker = "'$MONIKER'"/g'  "$GALACTICA_HOME/config/config.toml"
else
    sed -i 's/moniker = "validator"/moniker = "'$MONIKER'"/g'  "$GALACTICA_HOME/config/config.toml"
fi
```

### Genesis Transaction (Gentx)

First, set the staking amount:

> 1000000000000000000agnet === 1 GNET === 10^18 agnet
> 100000000000000000000agnet is 100 GNET === 10^20 agnet

```bash
export STAKE_AMOUNT=100000000000000000000agnet
```

Then ensure that MY_ADDRESS is set to your node's address:

```bash
export MY_ADDRESS=$(galacticad keys show $MONIKER -a --keyring-dir $GALACTICA_HOME --keyring-backend $KEYRING_BACKEND)
```

Before creating the gentx, ensure that you add your address to the genesis accounts:

```bash
galacticad add-genesis-account \
  $MY_ADDRESS \
  $STAKE_AMOUNT \
  --home "$GALACTICA_HOME"
```

Configure the gentx parameters by running the following commands:
```bash
ip=0.0.0.0
p2p_port=26656
commission_rate=0.1
commission_max_rate=0.2
commission_max_change_rate=0.01
details="Your details"
security_contact="Your security contact"
website="Your website"
identity="Your identity"
```

Now, create the gentx:

```bash
galacticad gentx \
    $MONIKER \
    $STAKE_AMOUNT \
    --amount $STAKE_AMOUNT \
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
    --chain-id $CHAIN_ID \
    --home $GALACTICA_HOME
```

Copy the gentx file to the network configuration directory to submit it as a public pull request to the [Galactica networks repository](https://github.com/Galactica-corp/networks).

```bash
cp "$(ls -t $GALACTICA_HOME/config/gentx/ | head -n1)" "$NETWORK_PATH/gentx/"
```

### Submitting the Gentx

After generating your gentx, submit it as public pull request to the [Galactica networks repository](https://github.com/Galactica-corp/networks). Ensure all information is accurate before proceeding.

Follow example of how to submit a gentx to the Galactica networks repository:

- Fork the Galactica networks repository.
- Clone the forked repository to your local machine.

- Create a new branch and switch to it:
  ```bash
  git checkout -b gentx-<your-moniker>
  ```
  
- Add the gentx file to the repository:
  ```bash
  git add $NETWORK_PATH/gentx/<gentx-file>
  ```
  
- Commit the changes:
    ```bash
    git commit -m "gentx: <your-moniker>"
    ```
  
- Push the changes to the repository:
    ```bash
    git push origin gentx-<your-moniker>
    ```
  
- Create a pull request on the Galactica networks repository.
  - Visit the [Galactica networks repository](https://github.com/Galactica-corp/networks).
  - Click on the "Pull requests" tab.
  - Click on the "New pull request" button.
  - Select the branch you just pushed and click "Create pull request".
  - Fill in the details and click "Create pull request".
  
