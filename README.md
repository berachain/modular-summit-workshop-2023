# Modular Summit Workshop

## Berachain x Celestia x OP Stack

From the root of this repo, build the docker image:

### 1. Start Celestia Local Devnet
```bash

docker run --platform linux/amd64 -p 26658:26658 -p 26659:26659 ghcr.io/rollkit/local-celestia-devnet:v0.11.0-rc8
```

### 2. Put Auth Token into polaris/cosmos/init.sh

This auth key is required to authorize the rollkit to post to the DA.
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
