// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721Enumerable} from "../../libs/ERC721Enumerable.sol";
import {ERC721} from "../../libs/ERC721.sol";

contract ERC721Test is ERC721Enumerable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 _mintAmount
    ) ERC721(name, symbol) {
        for (uint256 i = 0; i < _mintAmount; i++) {
            _mint(msg.sender, i);
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "TEST-BASE-URI";
    }
}
