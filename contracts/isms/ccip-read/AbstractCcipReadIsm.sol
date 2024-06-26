// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// ============ Internal Imports ============
import {ICcipReadIsm} from "../../interfaces/isms/ICcipReadIsm.sol";
import {IInterchainSecurityModule} from "../../interfaces/IInterchainSecurityModule.sol";



/**
 * @title AbstractCcipReadIsm
 * @notice An ISM that allows arbitrary payloads to be submitted and verified on chain
 * @dev https://eips.ethereum.org/EIPS/eip-3668
 * @dev The AbstractCcipReadIsm provided by Hyperlane is left intentially minimalist as
 * the range of applications that could be supported by a CcipReadIsm are so broad. However
 * there are few things to note when building a custom CcipReadIsm.
 *
 * 1. `getOffchainVerifyInfo` should revert with a `OffchainLookup` error, which encodes
 *    the data necessary to query for offchain information
 * 2. For full CCIP Read specification compatibility, CcipReadIsm's should expose a function
 *    that in turn calls `process` on the configured Mailbox with the provided metadata and
 *    message. This functions selector should be provided as the `callbackFunction` payload
 *    for the OffchainLookup error
 */
abstract contract AbstractCcipReadIsm is ICcipReadIsm {
    // ============ Constants ============

    // solhint-disable-next-line const-name-snakecase
    uint8 public constant moduleType =
        uint8(IInterchainSecurityModule.Types.CCIP_READ);
}
