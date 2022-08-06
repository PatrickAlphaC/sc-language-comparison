// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "src/interfaces/ISimpleStorage.sol";

contract SimpleStoreHuffTest is Test {
    ISimpleStorage simpleStorage;
    // Huff deployer uses a different method of naming file location
    string public constant hSimpleStorageLocation = "huff/HSimpleStorage";

    function setUp() public {
        simpleStorage = ISimpleStorage(
            HuffDeployer.config().deploy(hSimpleStorageLocation)
        );
    }

    function testCreationHuff() public {
        ISimpleStorage simpleStorageLocal = ISimpleStorage(
            HuffDeployer.config().deploy(hSimpleStorageLocation)
        );
        assert(address(simpleStorageLocal) != address(0));
    }

    function testStorageAndReadHuff() public {
        uint256 numberToStore = 77;
        simpleStorage.storeNumber(numberToStore);
        assert(numberToStore == simpleStorage.readNumber());
    }
}
