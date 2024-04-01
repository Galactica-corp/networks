# Scripts Directory

This directory contains several shell scripts that simplify the setup and management of your Galactica Network node.

# Scripts Usage Guide

This directory contains several scripts that simplify the setup and management of your Galactica Network node. Here's a quick guide:

## Prerequisites

- Install `jq` for JSON processing.
- Ensure the `galacticad` command-line tool is installed and accessible.


- Set `GALACTICA_HOME` to your node's home directory, e.g., `export GALACTICA_HOME=~/.galactica`.
- Set `CHAIN_ID` to your network chain ID, e.g., `export CHAIN_ID=galactica_9301-1`.
- Set `NETWORK_PATH` to your network configuration directory, e.g., `export NETWORK_PATH=./$CHAIN_ID`.
- Set `KEYRING_BACKEND` to your keyring backend, e.g., `export KEYRING_BACKEND=test`. You can use various keyring backends such as `os`, `file`, `test`, `kwallet`, `pass`, etc. To read more about keyring backends, visit [Evmos documentation](https://docs.evmos.org/protocol/concepts/keyring#keyring-backends)

```sh
export GALACTICA_HOME=~/.galactica
export CHAIN_ID=galactica_9301-1
export NETWORK_PATH=./$CHAIN_ID
export KEYRING_BACKEND=file
```

## Scripts Overview

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
  Follow the prompts to input staking amount, validator node IP, and P2P port, etc. The script will generate a new gentx file in the `./galactica_9301-1/gentx` directory.


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

- **update-seeds.sh**: Update seeds in config.toml 
  ```bash
  ./scripts/update-seeds.sh
  ```
  
Please refer to the individual scripts for more detailed usage instructions.  The script will display the public addresses in different formats and the private key if prompted.

