-include .env

.PHONY: all test clean

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install foundry-rs/forge-std --no-commit && forge install PatrickAlphaC/foundry-vyper --no-commit && forge install huff-language/foundry-huff --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

anvil :; anvil -m 'test test test test test test test test test test test junk'