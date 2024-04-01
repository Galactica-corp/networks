# Galactica Networks

This repository hosts the genesis configurations for the Galactica networks.

For detailed guidance on setting up and running a Galactica network node, please visit the [Galactica repository](https://github.com/Galactica-corp/galactica).

## Networks Overview

| Name                                 | Chain ID         | Environment | Configs                                |
|--------------------------------------|------------------|-------------|----------------------------------------|
| galactica-testnet-v1 (**Reticulum**) | galactica_9301-1 | testnet     | [galactica_9301-1](./galactica_9301-1) |

## Install [`galactica`](https://github.com/Galactica-corp/galactica)

To clone the Galactica Network node repository and install the `galacticad` command-line tool, run the following commands:

```sh
git clone https://github.com/Galactica-corp/galactica
cd galactica
git checkout ${VERSION}
make install
```
