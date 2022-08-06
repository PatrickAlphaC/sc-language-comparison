// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-vyper/VyperDeployer.sol";
import "forge-std/Test.sol";
import "src/interfaces/ISimpleStorage.sol";

contract SimpleStorageVyperTest is Test {
    VyperDeployer public vyperDeployer;
    ISimpleStorage simpleStorage;
    string public constant vyperSimpleStorageLocation =
        "src/vyper/VSimpleStorage.vy";
    bytes public simpleStorageVyByteCode;

    function setUp() public {
        vyperDeployer = new VyperDeployer();
        simpleStorage = ISimpleStorage(
            vyperDeployer.deployContract(vyperSimpleStorageLocation)
        );
        simpleStorageVyByteCode = vyperDeployer.compileVyper(
            vyperSimpleStorageLocation
        );
    }

    function testCreationVy() public {
        ISimpleStorage simpleStorageLocal = ISimpleStorage(
            vyperDeployer.deployContract(vyperSimpleStorageLocation)
        );
        assert(address(simpleStorageLocal) != address(0));
    }

    function testStorageAndReadVy() public {
        uint256 numberToStore = 77;
        simpleStorage.storeNumber(numberToStore);
        assert(numberToStore == simpleStorage.readNumber());
    }
}
