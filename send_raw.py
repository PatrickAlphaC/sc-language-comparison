from web3 import Web3
import os
import json
from web3.middleware import geth_poa_middleware

vy_bytecode = "0x61006961000f6000396100696000f36003361161000c57610053565b60003560e01c346100595763b63394188118610032576024361861005957600435600055005b63b63d343f811861005157600436186100595760005460405260206040f35b505b60006000fd5b600080fda165767970657283000304"


def main():
    w3 = Web3(Web3.HTTPProvider(os.getenv("RINKEBY_RPC_URL")))
    chain_id = 4
    abi = ""
    my_address = os.getenv("MY_ADDRESS")
    with open("abi.json") as fp:
        abi = fp.read()
    SimpleStorage = w3.eth.contract(abi=abi, bytecode=vy_bytecode)
    nonce = w3.eth.getTransactionCount(my_address)
    w3.middleware_onion.inject(geth_poa_middleware, layer=0)
    transaction = SimpleStorage.constructor().build_transaction(
        {
            "chainId": chain_id,
            "from": my_address,
            "nonce": nonce,
            "type": 2,
        }
    )
    signed_txn = w3.eth.account.sign_transaction(
        transaction, private_key=os.getenv("PRIVATE_KEY")
    )


if __name__ == "__main__":
    main()
