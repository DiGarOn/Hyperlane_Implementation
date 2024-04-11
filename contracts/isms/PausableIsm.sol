// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// ============ External Imports ============
import {Ownable} from "../../libs/Ownable.sol";
import {Pausable} from "../../libs/Pausable.sol";
// ============ Internal Imports ============
import {IInterchainSecurityModule} from "../interfaces/IInterchainSecurityModule.sol";
contract PausableIsm is IInterchainSecurityModule, Ownable, Pausable {
    uint8 public constant override moduleType = uint8(Types.NULL);

    /**
     * @inheritdoc IInterchainSecurityModule
     * @dev Reverts when paused, otherwise returns `true`.
     */
    function verify(bytes calldata, bytes calldata)
        external
        view
        whenNotPaused
        returns (bool)
    {
        return true;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}

