# Language Gas Comparisons

The purpose of this repo is to compare the following languages for performance (gas optimization):

- [Solidity](https://docs.soliditylang.org/en/v0.8.15/)
- [Solidity & in-line Yul](https://docs.soliditylang.org/en/v0.8.15/yul.html?highlight=yul)
- [Yul](https://docs.soliditylang.org/en/v0.8.15/yul.html?highlight=yul)
- [Vyper](https://vyper.readthedocs.io/en/stable/index.html)
- [Huff](https://huff.sh/)

# Table Of Contents

- [Language Gas Comparisons](#language-gas-comparisons)
- [Table Of Contents](#table-of-contents)
- [Working with this repo](#working-with-this-repo)
  - [Requirements](#requirements)
  - [Getting Started](#getting-started)
- [Contract Creation Gas Costs](#contract-creation-gas-costs)
  - [Yul](#yul)

# Working with this repo

## Requirements

-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  
    -   You'll know you've done it right if you can run `git --version`
-   [Foundry / Foundryup](https://github.com/gakonst/foundry)
    -   This will install `forge`, `cast`, and `anvil`
    -   You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
    -   To get the latest of each, just run `foundryup`
-   [Huff Compiler](https://docs.huff.sh/get-started/installing/)
    -   You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.2.0`
-   [Vyper Compiler](https://vyper.readthedocs.io/en/stable/installing-vyper.html)
    -   You'll know you've done it right if you can run `vyper --version` and get an output like: `0.3.4+commit.f31f0ec`
-   [Solidity Compiler](https://docs.soliditylang.org/en/latest/installing-solidity.html)
    -   You'll know you've done it right if you can run `solc --verison` and get an output like:
    -   `solc, the solidity compiler commandline interface Version: 0.8.7+commit.e28d00a7.Darwin.appleclang`


## Getting Started

1. Clone the repo

```
git clone https://github.com/PatrickAlphaC/sc-language-comparison
cd sc-language-comparison
make
```

2. Run tests

```
forge snapshot
```

You'll see the gas outputs in `.gas-snapshot`. This is a good outlook on gas costs on function calls, but not on contract creation. 

# Contract Creation Gas Costs

To test how much gas it costs to deploy a contract, we need to compile the contracts, get their bytecode, and deploy it in a raw transaction. 

This section is TODO:

## Yul

To compile raw yul:

```
solc --strict-assembly --optimize --optimize-runs 200 yul/YYSimpleStorage.yul --bin
```