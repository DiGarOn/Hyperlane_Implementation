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

// ============ Internal Imports ============




// ============ External Imports ============
import {CrossChainEnabledOptimism} from "../../../libs/CrossChainEnabledOptimism.sol";

/**
 * @title OPStackIsm
 * @notice Uses the native Optimism bridge to verify interchain messages.
 */
contract OPStackIsm is
    CrossChainEnabledOptimism,
    AbstractMessageIdAuthorizedIsm
{
    // ============ Constants ============

    uint8 public constant moduleType =
        uint8(IInterchainSecurityModule.Types.NULL);

    // ============ Constructor ============

    constructor(address _l2Messenger) CrossChainEnabledOptimism(_l2Messenger) {
        require(
            Address.isContract(_l2Messenger),
            "OPStackIsm: invalid L2Messenger"
        );
    }

    // ============ Internal function ============

    /**
     * @notice Check if sender is authorized to message `verifyMessageId`.
     */
    function _isAuthorized() internal view override returns (bool) {
        return _crossChainSender() == authorizedHook;
    }
}
