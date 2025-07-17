//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

contract ERC1155GrandRole is Script {
    function run(address _to) public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        address erc1155AuthAddress = vm.envAddress("ERC1155_AUTH_ADDRESS");

        ERC1155Auth erc1155AuthContract = ERC1155Auth(erc1155AuthAddress);

        erc1155AuthContract.grantRole(Roles.MINTER_ROLE, _to);
        console.log("Role MINTER_ROLE granted to:", _to);
    }
}