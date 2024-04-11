// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20Upgradeable} from "../../libs/ERC20Upgradeable.sol";

contract MockToken is ERC20Upgradeable {
    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }

    function burn(uint256 _amount) external {
        _burn(msg.sender, _amount);
    }
}
