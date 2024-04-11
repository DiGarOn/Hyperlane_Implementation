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
import {AbstractMessageIdAuthorizedIsm} from "./AbstractMessageIdAuthorizedIsm.sol";
import {IInterchainSecurityModule} from "../../interfaces/IInterchainSecurityModule.sol";


// ============ External Imports ============
import {Address} from "../../../libs/Address.sol";
/**
 * @title ERC5164Ism
 * @notice Uses the generic eip-5164 standard to verify interchain messages.
 */
contract ERC5164Ism is AbstractMessageIdAuthorizedIsm {
    // ============ Constants ============

    uint8 public constant moduleType =
        uint8(IInterchainSecurityModule.Types.NULL);
    // corresponding 5164 executor address
    address public immutable executor;

    // ============ Constructor ============

    constructor(address _executor) {
        require(Address.isContract(_executor), "ERC5164Ism: invalid executor");
        executor = _executor;
    }

    /**
     * @notice Check if sender is authorized to message `verifyMessageId`.
     */
    function _isAuthorized() internal view override returns (bool) {
        return msg.sender == executor;
    }
}
