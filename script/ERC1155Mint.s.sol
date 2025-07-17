// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

contract ERC1155Mint is Script {
    function run(address _to, uint256 _amount, string memory _tokenURI) public {
        uint256 minterPrivateKey = vm.envUint("MINTER_PRIVATE_KEY");

        vm.startBroadcast(minterPrivateKey);

        address erc1155AuthAddress = vm.envAddress("ERC1155_AUTH_ADDRESS");

        ERC1155Auth erc1155AuthContract = ERC1155Auth(erc1155AuthAddress);

        erc1155AuthContract.mint(_to, _amount, _tokenURI);
        console.log("Token successfully minted to: ", _to);
    }
}
