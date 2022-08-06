// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/yulsol/YSimpleStorage.sol";

contract SimpleStorageYulTest is Test {
    YSimpleStorage public simpleStorage;

    function setUp() public {
        simpleStorage = new YSimpleStorage();
    }

    function testCreationYul() public {
        YSimpleStorage simpleStorageLocal = new YSimpleStorage();
        assert(address(simpleStorageLocal) != address(0));
    }

    function testStorageAndReadYul() public {
        uint256 numberToStore = 77;
        simpleStorage.storeNumber(numberToStore);
        assert(numberToStore == simpleStorage.readNumber());
    }
}
