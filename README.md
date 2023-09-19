# ClimateCoin

This is a Climate-focused project designed to rewards citizens with climate coin with carbon credits for climate change mitigation efforts. The goal is reduce the friction in Digital Monitorting, Review and Verification (D-MRV) by adding a registry for carbon credits and enabling on-chain rewards. This project seeks to demonstrate how D-MRV systems can be used to underpin future carbon markets under the goals
of the Paris Agreement by utilizing the smart contracts and reducing barriers to adoption. 

The use of blockchain technology to create immutable and auditable data and transfer records, including the creation of mitigation outcomes in digital form underpinned by smart contracts, is another important component of end-to-end digitalization of carbon markets that the industry requires.

To achieve this, the project contains a simple smart contract that achieves the following fuctions.

## Monitoring
A new farmer is registered by an administrator first. The administrator needs to indicate the total acerage of the farmer.

The farmer can then add a claim for consideration.

## Review & Verification

An admin can then verify pending submissions.

## Rewards
When an admin verifies a submission, ClimateCoin can then be allocated to participating farmers.


## Getting Started

Clone the repo and install dependencies

```shell
npm i
```

Create a .env file

```shell
cp .env-example .env;
```

Update .env to set your PRIVATE_KEY, ETHERSCAN_API_KEY, and POLYSCAN_API_KEY for Mumbai or ZKEVM_POLYSCAN_API_KEY for Polygon zkEVM environment variables.


Try running some of the following tasks to compile and create contract.

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts --network zkevmtestnent
```

My climatecoin contract
Polygon zkEVM: https://testnet-zkevm.polygonscan.com/address/0x2CCdB646497A5432D82b68BC9b107DE0aC9c6770
Mumbai: https://mumbai.polygonscan.com/address/0xb99460c473f65F8d84297A2Fa3262003283A5100


Update the command to use your contract address, then verify your contract

```shell
npx hardhat verify --network zkevmtestnet <your-contract-address> 1000
```

The result is your verified source code. Here's mine:

Polygon zkEVM Testnet: https://testnet-zkevm.polygonscan.com/address/0x2CCdB646497A5432D82b68BC9b107DE0aC9c6770#code
Mumbai:https://mumbai.polygonscan.com/address/0xb99460c473f65F8d84297A2Fa3262003283A5100#code
