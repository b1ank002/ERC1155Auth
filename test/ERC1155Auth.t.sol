// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

contract ERC1155AuthTest is Test {
    ERC1155Auth erc1155Auth;

    address public admin = address(1);
    address public manager = address(2);
    address public minter = address(3);
    address public user = address(4);
    address public user1 = address(5);

    function setUp() public {
        vm.startPrank(admin);
        erc1155Auth = new ERC1155Auth();
        erc1155Auth.grantRole(Roles.MINTER_ROLE, minter);
        erc1155Auth.grantRole(Roles.MANAGER_ROLE, manager);
        vm.stopPrank();
    }

    function testDeployment() public view {
        assert(address(erc1155Auth) != address(0));

        assertTrue(erc1155Auth.hasRole(erc1155Auth.DEFAULT_ADMIN_ROLE(), admin));
        assertTrue(erc1155Auth.hasRole(Roles.MINTER_ROLE, minter));
        assertTrue(erc1155Auth.hasRole(Roles.MANAGER_ROLE, manager));

        console.log("ERC1155Auth deployed to:", address(erc1155Auth));
    }

    function test_mint_Success(uint256 _amount, string memory _tokenURI) public {
        vm.assume(_amount > 0);
        vm.assume(keccak256(abi.encodePacked(_tokenURI)) != keccak256(abi.encodePacked("")));

        vm.prank(minter);
        erc1155Auth.mint(user, _amount, _tokenURI);

        assertTrue(erc1155Auth.hasToken(user, 0));
        assertEq(erc1155Auth.uri(0), _tokenURI);
    }

    function test_updateTokenUri_Success(uint256 _amount, string memory _tokenURI, string memory _nextTokenURI)
        public
    {
        vm.assume(_amount > 0);
        vm.assume(keccak256(abi.encodePacked(_tokenURI)) != keccak256(abi.encodePacked("")));
        vm.assume(keccak256(abi.encodePacked(_nextTokenURI)) != keccak256(abi.encodePacked("")));

        test_mint_Success(_amount, _tokenURI);

        vm.prank(manager);
        erc1155Auth.updateTokenUri(0, _tokenURI);

        assertEq(erc1155Auth.uri(0), _tokenURI);
    }
}
