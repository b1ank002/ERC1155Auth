// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {TestAuth} from "../src/TestAuth.sol";

contract AuthTestDeploy is Script {
    function run() public {
        uint256 deployPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address erc1155AuthAddress = vm.envAddress("ERC1155_AUTH_ADDRESS");

        vm.startBroadcast(deployPrivateKey);

        TestAuth testAuth = new TestAuth(erc1155AuthAddress);

        console.log("TestAuth deployed to:", address(testAuth));
    }
}
