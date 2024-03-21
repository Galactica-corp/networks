# 🔗 `galactica_9301-1`

![chain-id](https://img.shields.io/badge/chain%20id-galactica_9301--1-blue?style=for-the-badge)
![version: v0.1.0](https://img.shields.io/badge/version-v0.1.0-green?style=for-the-badge)


## Install [`galactica`](https://github.com/Galactica-corp/galactica)

To clone the networks repository, run:

```sh
git clone https://github.com/Galactica-corp/galactica
cd galactica
git checkout v0.1.0
make install
```

## Register in the Genesis

To register your validator node in the `genesis.json` you just need to provide a signed `gentx` with an initial delegation of `10 $GNET`.

```sh
# Init node
galacticad init your-moniker --chain-id galactica_9301-1

# Create keys, be careful with the mnemonic 👀
galacticad keys add your-key-name

# Set account necessary balance with 100 $GNET
galacticad add-genesis-account your-key-name 100000000000000000000agnet --keyring-backend=os
```
*NOTE*: if you are submitting a gentx for a new account, (meaning you had to run the command above because the account did not have balance) be aware that you will be granted some funds (including the 100000000000000000000agnet required as min self-delegation), enough to pay for fees. The amount above is indicative of the actual amount of funds you will be granted, but the final amount might change.

Then create your own genesis transaction (`gentx`). You will have to choose the following parameters for your validator: `commission-rate`, `commission-max-rate`, `commission-max-change-rate` all set to 0, `min-self-delegation` (>=1), `website` (optional), `details` (optional), `identity` ([keybase](https://keybase.io) key hash, used to get validator logos in block explorers - optional), `security-contact` (email - optional).

The `commission-rate`, `commission-max-rate`, `commission-max-change-rate` are recommended to be set to 0  since rewards and inflations are both set to 0.

```sh
# Create the gentx
galacticad gentx your-key-name  10000000000000000000agnet \
  --node-id $(galacticad tendermint show-node-id) \
  --chain-id galactica_9301-1 \
  --commission-rate 0.05 \
  --commission-max-rate 0.1 \
  --commission-max-change-rate 0.02 \
  --min-self-delegation 1 \
  --website "https://foo.network" \
  --details "My validator" \
  --identity "id-from-keybase" \
  --security-contact "security@foo.network"
```
