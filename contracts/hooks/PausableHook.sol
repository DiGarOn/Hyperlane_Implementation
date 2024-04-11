// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*@@@@@@@       @@@@@@@@@
 @@@@@@@@@       @@@@@@@@@
  @@@@@@@@@       @@@@@@@@@
   @@@@@@@@@       @@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@
     @@@@@  HYPERLANE  @@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@
   @@@@@@@@@       @@@@@@@@@
  @@@@@@@@@       @@@@@@@@@
 @@@@@@@@@       @@@@@@@@@
@@@@@@@@@       @@@@@@@@*/

import {AbstractPostDispatchHook} from "./libs/AbstractPostDispatchHook.sol";
import {StandardHookMetadata} from "./libs/StandardHookMetadata.sol";


import {Ownable} from "../../libs/Ownable.sol";
import {Pausable} from "../../libs/Pausable.sol";


contract PausableHook is AbstractPostDispatchHook, Ownable, Pausable {
    using StandardHookMetadata for bytes;

    // ============ External functions ============

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    // ============ Internal functions ============

    /// @inheritdoc AbstractPostDispatchHook
    function _postDispatch(bytes calldata metadata, bytes calldata message)
        internal
        override
        whenNotPaused
    {}

    /// @inheritdoc AbstractPostDispatchHook
    function _quoteDispatch(bytes calldata, bytes calldata)
        internal
        pure
        override
        returns (uint256)
    {
        return 0;
    }
}
