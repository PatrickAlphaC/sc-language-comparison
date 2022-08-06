// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/solidity/SSimpleStorage.sol";

contract SimpleStorageSolidityTest is Test {
    SSimpleStorage simpleStorage;

    function setUp() public {
        simpleStorage = new SSimpleStorage();
    }

    function testCreationSol() public {
        SSimpleStorage simpleStorageLocal = new SSimpleStorage();
        assert(address(simpleStorageLocal) != address(0));
    }

    function testStorageAndReadSol() public {
        uint256 numberToStore = 77;
        simpleStorage.storeNumber(numberToStore);
        assert(numberToStore == simpleStorage.readNumber());
    }
}
