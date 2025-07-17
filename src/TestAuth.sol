//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IERC1155Auth} from "./IERC1155Auth.sol";

contract TestAuth {
    IERC1155Auth public auth;

    mapping(address => bool) public partisipations;

    error UserDontHaveToken();

    constructor(address _auth) {
        auth = IERC1155Auth(_auth);
    }

    function participate() external {
        require(auth.hasToken(msg.sender, 0), UserDontHaveToken());
        partisipations[msg.sender] = true;
    }
}
