# Aztec Sequencer Node Guide

Aztec is building a decentralized, privacy-focused network running on ethereum. We are to run two nodes; validator & sequencer nodes. This guide will walk you through setting a testnet node.

## 💻 Prerequisites

| Component      | Specification             |
| -------------- | ------------------------- |
| CPU            | 4-core Processor          |
| RAM            | 6-24 GiB                  |
| Storage        | 25- 1 TB SSD              |
| Internet Speed | 25 Mbps Upload / Download |

## 🌐 Rent VPS

**Note: Renting VPS is not necessarily needed if your main goal is to take `Apprentice` role on Aztec Discord, in that case you dont need to run it for long.

* Visit: contabo or hetzner to rent a VPS

## ⚙️ setup

* You can use Alchemy or Infura to get Sepolia Ethereum RPC. I suggest you use Ankr premium for longer & more stable connection.

* Create a new evm wallet and fund it with at least 2.5 Sepolia ETH if you want to register as Validator.


## 📥 Installation

* Install `curl` and `wget` first:
```bash
(command -v curl >/dev/null 2>&1 && command -v wget >/dev/null 2>&1) || sudo apt-get update; command -v curl >/dev/null 2>&1 || sudo apt-get install -y curl; command -v wget >/dev/null 2>&1 || sudo apt-get install -y wget
```

* Execute either of the following commands to run your Aztec node:
```bash
[ -f "aztec.sh" ] && rm aztec.sh; curl -sSL -o aztec.sh https://raw.githubusercontent.com/zunxbt/aztec-sequencer-node/main/aztec.sh && chmod +x aztec.sh && ./aztec.sh
```

or

```bash
[ -f "aztec.sh" ] && rm aztec.sh; wget -q -O aztec.sh https://raw.githubusercontent.com/zunxbt/aztec-sequencer-node/main/aztec.sh && chmod +x aztec.sh && ./aztec.sh
```

## ⚡ Commands

* Check logs of your node:
```bash
sudo docker logs -f --tail 100 $(docker ps -q --filter ancestor=aztecprotocol/aztec:latest | head -n 1)
```

* Stop the node:
```bash
sudo docker stop $(docker ps -q --filter ancestor=aztecprotocol/aztec:latest | head -n 1)
```

## 🧩 Post-Installation

**Note: After running node, you should wait at least 10 to 20 mins before your run these commands**

* Get `block-number`:
```bash
curl -s -X POST -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"node_getL2Tips","params":[],"id":67}' http://localhost:8080 | jq -r '.result.proven.number'
```

* After running this code, you will get a block number like this: 12345
* Use that block number in the places of `block-number` in the below command to get `proof`:
```bash
curl -s -X POST -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"node_getArchiveSiblingPath","params":["block-number","block-number"],"id":67}' http://localhost:8080 | jq -r ".result"
```

* Now join Aztec Discord Server
* Go to  `operators | start-here` channel
* Use the following command to get `Apprentice` role:
```
/operator start
```

* It will ask for the `address`, `block-number` and `proof`. Enter all of them one by one and you will get `Apprentice` instantly.

## Register as Validator

**Warning: You may see an error like `ValidatorQuotaFilledUntil` when trying to register as a validator, which means the daily quota has been reached—convert the provided Unix timestamp to local time to know when you can try again to register as Validator or try to join early next day.**

* Replace `SEPOLIA-RPC-URL`, `YOUR-PRIVATE-KEY`, `YOUR-VALIDATOR-ADDRESS` with actual values and then execute this command:
```bash
aztec add-l1-validator \
  --l1-rpc-urls SEPOLIA-RPC-URL \
  --private-key YOUR-PRIVATE-KEY \
  --attester YOUR-VALIDATOR-ADDRESS \
  --proposer-eoa YOUR-VALIDATOR-ADDRESS \
  --staking-asset-handler 0xF739D03e98e23A7B65940848aBA8921fF3bAc4b2 \
  --l1-chain-id 11155111
``` 