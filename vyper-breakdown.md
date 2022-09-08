Work in progress

Binary:
```
61006b61000f60003961006b6000f36003361161000c57610053565b60003560e01c346100595763b63394188118610032576024361861005957600435600055005b63b63d343f811861005157600436186100595760005460405260206040f35b505b60006000fd5b600080fda165767970657283000306000b
```

Opcodes:
```
PUSH2 0x06B PUSH2 0x0F PUSH1 0x0 CODECOPY PUSH2 0x06B PUSH1 0x0 RETURN PUSH1 0x3 CALLDATASIZE GT PUSH2 0x0C JUMPI PUSH2 0x053 JUMP JUMPDEST PUSH1 0x0 CALLDATALOAD PUSH1 0xE0 SHR CALLVALUE PUSH2 0x059 JUMPI PUSH4 0xB6339418 DUP2 XOR PUSH2 0x032 JUMPI PUSH1 0x24 CALLDATASIZE XOR PUSH2 0x059 JUMPI PUSH1 0x4 CALLDATALOAD PUSH1 0x0 SSTORE STOP JUMPDEST PUSH4 0xB63D343F DUP2 XOR PUSH2 0x051 JUMPI PUSH1 0x4 CALLDATASIZE XOR PUSH2 0x059 JUMPI PUSH1 0x0 SLOAD PUSH1 0x40 MSTORE PUSH1 0x20 PUSH1 0x40 RETURN JUMPDEST POP JUMPDEST PUSH1 0x0 PUSH1 0x0 REVERT JUMPDEST PUSH1 0x0 DUP1 REVERT LOG1 PUSH6 0x767970657283 STOP SUB MOD STOP SIGNEXTEND
```

# Contract Creation Code

Copy the runtime code onto the blockchain, and then return.

```
61006b61000f60003961006b6000f3
```

# Contract Runtime Code

Check the calldata size for a function selector, and jump into finding the function selector if it's good
```
6003361161000c57
```

Add 83 to the stack, then jump 
```
61005356
```

Get function seletor
```
5b60003560e01c
```

Jump if someone sent ETH with this transaction
```
3461005957
```

Check to see if the function selector is `b6339418` (storeNumber), and store the jump location on the stack if so
```
63b6339418811861003257
```

This does a jump if the call data size has enough space for a uint256? 
```
6024361861005957
```

Store your number in slot 0, and end the call
```
60043560005500
```

This adds `b63d343f` to the stack (readNumber function selector), and we jump to the readNumber selector if so

```
5b63b63d343f811861005157
```

Check the call data size... again? 
```
6004361861005957
```

Loads our number from storage (readNumber), and return the number
```
60005460405260206040f3
```

Revert jump destination when calldata is the wrong size, or eth is sent
```
5b505b60006000fd
```

Another jump destination for a revert? 
```
5b600080fd
```

# Metadata
```
a165767970657283000306000b
```