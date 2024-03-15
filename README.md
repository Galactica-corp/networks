# Galactica Networks

This repository hosts the genesis configurations for the Galactica networks.

For detailed guidance on setting up and running a Galactica network node, please visit the [Galactica repository](https://github.com/Galactica-corp/galactica).

## Networks Overview

| Name             | Chain ID | Environment | Configs                                                |
|------------------|----------|-------------|--------------------------------------------------------|
| galactica_9301-1 | 9301     | testnet     | [galactica_9301-1](./network/testnet/galactica_9301-1) |

## Using the Scripts

The scripts in the `scripts` directory simplify the setup and management of your Galactica Network node. Here's a quick guide:

### Prerequisites

- Install `jq` for JSON processing.
- Set `GALACTICA_HOME` to your node's home directory, e.g., `export GALACTICA_HOME=~/.galactica`.
- Set `NETWORK_PATH` to your network configuration directory, e.g., `export NETWORK_PATH=./network/testnet/galactica_9301-1`.
- Ensure the `galacticad` command-line tool is installed and accessible.

### Scripts Overview

- **create-home.sh**: Initializes the node's home directory with necessary configuration files. You can specify a custom home directory with the `GALACTICA_HOME` environment variable. This environment variable uses in all scripts.
  ```bash
  ./scripts/create-home.sh
  ```
  Enter a moniker for your node when prompted. 

- **create-key.sh**: Creates a new private key for node security and transactions.
  ```bash
  ./scripts/create-key.sh
  ```
  Enter a key name when prompted. If the key exists, it will be displayed; otherwise, a new key is created.

- **create-tx.sh**: Generates a new genesis transaction (gentx) for registering your validator node.
  ```bash
  ./scripts/create-tx.sh
  ```
  Follow the prompts to input staking amount, validator node IP, and P2P port.

### Final Steps

After generating your gentx, submit it as public pull request to the [Galactica networks repository](https://github.com/Galactica-corp/networks). Ensure all information is accurate before proceeding.

