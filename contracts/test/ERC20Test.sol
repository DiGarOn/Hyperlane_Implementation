// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "../../libs/ERC20.sol";

contract ERC20Test is ERC20 {
    uint8 public immutable _decimals;

    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply,
        uint8 __decimals
    ) ERC20(name, symbol) {
        _decimals = __decimals;
        _mint(msg.sender, totalSupply);
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }
}
