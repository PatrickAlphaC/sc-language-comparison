object "YYSimpleStorage" {
     code {
        // Contract deployment
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
     }
     object "runtime" {
        code {
            // The MAIN function of the contract, function dispatcher
            switch selector()
            // cast sig "storeNumber(uint256)"
            case 0xb6339418 {
                storeNumber(decodeAsUint(0))
                returnTrue()
            }
            // cast sig "readNumber()"
            case 0xb63d343f{
                returnUint(readNumber())
            }
            default {
                revert(0, 0)
            }

            function storeNumber(newNumber) {
                sstore(0, newNumber)
            }

            function readNumber() -> storedNumber{
                storedNumber := sload(0)
            }

            /* ---------- calldata decoding functions ----------- */
            function selector() -> s {
                s := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
            }

            function decodeAsUint(offset) -> v {
                let pos := add(4, mul(offset, 0x20))
                if lt(calldatasize(), add(pos, 0x20)) {
                    revert(0, 0)
                }
                v := calldataload(pos)
            }

            function returnUint(v) {
                mstore(0, v)
                return(0, 0x20)
            }

            function returnTrue() {
                returnUint(1)
            }
        }
     }
}
