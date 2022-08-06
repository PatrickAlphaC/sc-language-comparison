-include .env

.PHONY: all test clean

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install foundry-rs/forge-std && forge install PatrickAlphaC/foundry-vyper && forge install huff-language/foundry-huff

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot