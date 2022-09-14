// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract YSimpleStorage {
    uint256 storedNumber;

    function storeNumber(uint256 newNumber) external {
        assembly {
            sstore(storedNumber.slot, newNumber)
        }
    }

    function readNumber() external view returns (uint256) {
        assembly {
            let num := sload(storedNumber.slot)
            mstore(0, num)
            return(0, 0x20)
        }
    }
}
