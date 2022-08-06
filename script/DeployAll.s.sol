// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "foundry-huff/HuffDeployer.sol";
import "src/interfaces/ISimpleStorage.sol";

// import {HuffConfig} from "lib/foundry-huff/src/HuffDeployer.sol";

contract DeployAll is Script {
    function run() external {
        uint256 numberToStore = 123;

        HuffConfig hf = HuffDeployer.config();

        vm.startBroadcast();

        // 1. Solidity
        // 2. Yul
        // 3. Vyper
        // 4. Huff

        // SimpleStorage simpleStorageSol = new SimpleStorage();
        // simpleStorageSol.storeNumber(numberToStore);

        // SimpleStorageYul simpleStorageYul = new SimpleStorageYul();
        // simpleStorageYul.storeNumber(numberToStore);

        // ISimpleStorage simpleStorageVy = ISimpleStorage(
        //     vyperDeployer.deployContract("SimpleStorage")
        // );
        // simpleStorageVy.storeNumber(numberToStore);

        // ISimpleStorage simpleStorage = ISimpleStorage(
        //     hf.deploy("SimpleStoreHuff")
        // );
        // simpleStorage.storeNumber(numberToStore);

        // vm.stopBroadcast();
    }
}
