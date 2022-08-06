from web3 import Web3, eth
import os
import json
from web3.middleware import geth_poa_middleware
from enum import Enum

RPC_URL = "http://localhost:8545"  # anvil
PRIVATE_KEY = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
MY_ADDRESS = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"


class Language(Enum):
    HUFF = 0
    VY = 1
    SOL = 2
    YUL = 3
    YYL = 4


def main():
    w3 = Web3(Web3.HTTPProvider(RPC_URL))
    chain_id = 31337
    abi = ""
    my_address = Web3.toChecksumAddress(MY_ADDRESS)
    with open("simple_storage_abi.json") as fp:
        abi = fp.read()
    bytecodes = get_bytecodes()
    if chain_id == 4:
        w3.middleware_onion.inject(geth_poa_middleware, layer=0)
    index = 0
    for bytecode in bytecodes:
        simple_storage = w3.eth.contract(abi=abi, bytecode=bytecode)
        nonce = w3.eth.getTransactionCount(my_address)
        transaction = simple_storage.constructor().build_transaction(
            {
                "chainId": chain_id,
                "from": my_address,
                "nonce": nonce,
                "type": "0x2",
                "maxFeePerGas": 2000000000,  # Change for rinkeby
                "maxPriorityFeePerGas": 1000000000,  # Change for rinkeby
            }
        )
        signed_txn = w3.eth.account.sign_transaction(
            transaction, private_key=PRIVATE_KEY
        )
        tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
        tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        # print(f"{Language(index)} gas on contract creation: {tx_receipt.gasUsed}")
        print(f"{tx_receipt.gasUsed} gas for {Language(index)}")
        index = index + 1


# This func gross
def get_bytecodes():
    bytecodes = []
    with open("bytecodes/huff/HSimpleStorage") as fp:
        bytecode = fp.read().replace("\n", "")
        bytecodes.append("0x" + bytecode if not bytecode.startswith("0x") else bytecode)
    with open("bytecodes/vy/VSimpleStorage") as fp:
        bytecode = fp.read().replace("\n", "")
        bytecodes.append("0x" + bytecode if not bytecode.startswith("0x") else bytecode)
    with open("bytecodes/sol/SSimpleStorage") as fp:
        bytecode = fp.read().replace("\n", "")
        bytecodes.append("0x" + bytecode if not bytecode.startswith("0x") else bytecode)
    with open("bytecodes/yul/YSimpleStorage") as fp:
        bytecode = fp.read().replace("\n", "")
        bytecodes.append("0x" + bytecode if not bytecode.startswith("0x") else bytecode)
    with open("bytecodes/yul/YYSimpleStorage") as fp:
        bytecode = fp.read().replace("\n", "")
        bytecodes.append("0x" + bytecode if not bytecode.startswith("0x") else bytecode)
    return bytecodes


if __name__ == "__main__":
    main()
