// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.30;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {IERC1155Auth} from "./IERC1155Auth.sol";
import {Roles} from "./Roles.sol";

contract ERC1155Auth is IERC1155Auth, ERC1155, AccessControl {

    constructor() ERC1155("000") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    uint256 private currentTokenId;

    mapping(uint256 => string) private _tokenURIs;

    function mint(address account, uint256 amount, string memory _tokenURI)
        public
        onlyRole(Roles.MINTER_ROLE)
    {
        require(amount > 0);
        require(keccak256(abi.encodePacked(_tokenURI)) != keccak256(abi.encodePacked("")));

        uint256 id = currentTokenId++;
        _mint(account, id, amount, "");
        _tokenURIs[id] = _tokenURI;
    }

    function updateTokenUri(uint256 _tokenId, string memory _newTokenURI) external onlyRole(Roles.MANAGER_ROLE) {
        require(keccak256(abi.encodePacked(_tokenURIs[_tokenId])) != keccak256(abi.encodePacked("")));
        _tokenURIs[_tokenId] = _newTokenURI;
    }

    function hasToken(address _user, uint256 _tokenId) external view returns (bool) {
        return balanceOf(_user, _tokenId) > 0;
    }

    function uri(uint256 _tokenId) public view override returns (string memory) {
        return _tokenURIs[_tokenId];
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC1155, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
