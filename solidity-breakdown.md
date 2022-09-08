Binary with metadata:
```
6080604052348015600f57600080fd5b5060ac8061001e6000396000f3fe6080604052348015600f57600080fd5b506004361060325760003560e01c8063b6339418146037578063b63d343f146049575b600080fd5b60476042366004605e565b600055565b005b60005460405190815260200160405180910390f35b600060208284031215606f57600080fd5b503591905056fea2646970667358221220111288e4086274ee3fb300e895a6951b5eabae71a4832b2c422ccc5d7622ceeb64736f6c634300080f0033
```

Binary withouyt metadata:

```
6080604052348015600f57600080fd5b5060838061001e6000396000f3fe6080604052348015600f57600080fd5b506004361060325760003560e01c8063b6339418146037578063b63d343f146049575b600080fd5b60476042366004605e565b600055565b005b60005460405190815260200160405180910390f35b600060208284031215606f57600080fd5b503591905056fea164736f6c634300080f000a
```

Opcodes:
```
PUSH1 0x80 PUSH1 0x40 MSTORE CALLVALUE DUP1 ISZERO PUSH1 0xF JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH1 0xAC DUP1 PUSH2 0x1E PUSH1 0x0 CODECOPY PUSH1 0x0 RETURN INVALID PUSH1 0x80 PUSH1 0x40 MSTORE CALLVALUE DUP1 ISZERO PUSH1 0xF JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH1 0x4 CALLDATASIZE LT PUSH1 0x32 JUMPI PUSH1 0x0 CALLDATALOAD PUSH1 0xE0 SHR DUP1 PUSH4 0xB6339418 EQ PUSH1 0x37 JUMPI DUP1 PUSH4 0xB63D343F EQ PUSH1 0x49 JUMPI JUMPDEST PUSH1 0x0 DUP1 REVERT JUMPDEST PUSH1 0x47 PUSH1 0x42 CALLDATASIZE PUSH1 0x4 PUSH1 0x5E JUMP JUMPDEST PUSH1 0x0 SSTORE JUMP JUMPDEST STOP JUMPDEST PUSH1 0x0 SLOAD PUSH1 0x40 MLOAD SWAP1 DUP2 MSTORE PUSH1 0x20 ADD PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 RETURN JUMPDEST PUSH1 0x0 PUSH1 0x20 DUP3 DUP5 SUB SLT ISZERO PUSH1 0x6F JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP CALLDATALOAD SWAP2 SWAP1 POP JUMP INVALID LOG2 PUSH5 0x6970667358 0x22 SLT KECCAK256 GT SLT DUP9 0xE4 ADDMOD PUSH3 0x74EE3F 0xB3 STOP 0xE8 SWAP6 0xA6 SWAP6 SHL 0x5E 0xAB 0xAE PUSH18 0xA4832B2C422CCC5D7622CEEB64736F6C6343 STOP ADDMOD 0xF STOP CALLER
```

This is the bytecode for our SSimpleStorage.sol... Let's break it down.

# Contract Creation Code

Free memory pointer
```
6080604052
``` 

Check if ETH is sent with a function call, revert if so
```
348015600f57600080fd
``` 

Jumps here if no ETH is sent with constructor, and copies the runtime code to memory
```
5b5060ac8061001e600039
```

Returns the runtime code. The runtime code is what get placed onto the blockchain. In our contract creation transaction, this is where it ends.
```
6000f3fe
```

# Runtime Code

## Entering the Contract

Free memory pointer
```
6080604052
```

Check if ETH is sent with a function call, revert if so
```
348015600f57600080fd
```

Short calldata check, and if size is too small (not big enough to have a function selector), jump to the fallback function (none)
```
5b5060043610603257
```

Get function seletor
```
60003560e01c
```

Check to see if the function selector is `b6339418` (storeNumber), and store the jump location on the stack if so
```
8063b633941814603757
```

Check to see if the function selector is `b63d343f` (readNumber), and store the jump location on the stack if so
```
8063b63d343f14604957
```

## Function Bodies & Wrappers

You'll notice they all start with `5b`, which is the `JUMPDEST` opcode, meaning these are each jump destinations.

Fallback function... there isn't one, so revert
```
5b600080fd
```

Unpack the calldata, but we actually jump below to do some calldata validation
```
5b60476042366004605e56
```

### storeNumber jump destination

Write to storage slot 0, and end the call
```
5b600055565b00
```

### readNumber jump destination

Read from storage slot 0

It has to move memory around to have it return from the stack, and then ends the call with a return. 
```
5b60005460405190815260200160405180910390f3
```

### Calldata validation

We check to make sure our calldata is the right size (our store number isn't too big. This is different than the check above which checked for a function selector based on size. )
```
5b600060208284031215606f57
```

If it is too big, we revert
```
600080fd
```

The function body jump location is currently low on the stack, bubble it up and jump to it 
```
5b503591905056
```

# Metadata

Breakpoint:

```
fe
```

And then, solidity adds a hash of metadata for the contract (we can ignore this!)

We have a version of the code without the metadata. The contract will work fine, but etherscan won't be able to verify it. 
```
a2646970667358221220111288e4086274ee3fb300e895a6951b5eabae71a4832b2c422ccc5d7622ceeb64736f6c634300080f0033
```