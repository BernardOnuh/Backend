# Fundme Contract

There are three solidity files here,

Fundme.sol : This  smartcontract file creates a decentralized medium to transfer
 funds between funders(senders/donors) to the creator of the smart contract.

PriceConverter.sol : This smart contract file converts the price of ETH to USD and vice versa
with the help of an Oracle Chain.link

userFundme.sol : This smart contract file is a child contract of Fundme.sol.

Try running some of the following tasks:

npm install :to install all dependencies

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
