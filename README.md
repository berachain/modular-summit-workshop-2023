# Dev n Tell Workshop - Developer DAO

## Berachain Polaris x Celestia Light Node

First, clone this repository. Then from the root of this repo, build the docker image:

<!-- TODO update this to use light node -->

### 1. Start Celestia Local Devnet
```bash

docker run --platform linux/amd64 -p 26658:26658 -p 26659:26659 ghcr.io/rollkit/local-celestia-devnet:v0.11.0-rc8
```

### 2. Put Auth Token into polaris/cosmos/init.sh

This auth key is required to authorize rollkit to post to the DA.

![sleep](assets/step2.png)

Place it in `polaris/cosmos/init.sh`

![sleep](assets/step2.1.png)

### 3. Install Foundry && Start the Polaris Chain

```bash
curl -L https://foundry.paradigm.xyz | bash
```
Then in a new window

```bash
foundryup
cd polaris && mage start
```

### 4. The following private key has funds on the Polaris Chain
```bash
Address: 0x20f33CE90A13a4b5E7697E3544c3083B8F8A51D4
PrivateKey: 0xfffdbb37105441e14b0ee6330d855d8504ff39e705c3afa8f859ac9865f99306
```

### 5. Clone the GM Portal repository

```bash
cd $HOME
git clone https://github.com/jcstein/gm-portal.git
cd gm-portal/frontend
yarn && yarn dev
```

Export private keys:

```bash
export PRIVATE_KEY=0xfffdbb37105441e14b0ee6330d855d8504ff39e705c3afa8f859ac9865f99306
export RPC_URL=http://localhost:8545
```

### 6. Deploy the GM Portal

```bash
cd $HOME/gm-portal/contracts
forge script script/GmPortal.s.sol:GmPortalScript --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

Set the contract address as a variable:

```bash
export CONTRACT_ADDRESS=<your contract address from the output above>
```

### 7. Interact with the contract

Send a "gm" to the contract:

```bash
cast send $CONTRACT_ADDRESS \
"gm(string)" "gm" \
--private-key $PRIVATE_KEY \
--rpc-url $RPC_URL
```

Get total GMs:

```bash
cast call $CONTRACT_ADDRESS "getTotalGms()" --rpc-url $RPC_URL
```

### 8. Update the frontend

https://docs.celestia.org/developers/gm-portal-bubs/#update-the-frontend
