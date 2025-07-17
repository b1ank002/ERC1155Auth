//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

contract ERC1155AuthDeploy is Script {
    function run() public {
        uint256 deployPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployPrivateKey);

        ERC1155Auth erc1155Auth = new ERC1155Auth();

        console.log("ERC1155Auth deployed to:", address(erc1155Auth));
    }
}
