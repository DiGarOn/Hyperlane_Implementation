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
import {AbstractMessageIdAuthHook} from "../libs/AbstractMessageIdAuthHook.sol";
import {IMessageDispatcher} from "../../interfaces/hooks/IMessageDispatcher.sol";



// ============ External Imports ============
import {Address} from "../../../libs/Address.sol";

/**
 * @title 5164MessageHook
 * @notice Message hook to inform the 5164 ISM of messages published through
 * any of the 5164 adapters.
 */
contract ERC5164Hook is AbstractMessageIdAuthHook {
    IMessageDispatcher public immutable dispatcher;

    constructor(
        address _mailbox,
        uint32 _destinationDomain,
        address _ism,
        address _dispatcher
    ) AbstractMessageIdAuthHook(_mailbox, _destinationDomain, _ism) {
        require(
            Address.isContract(_dispatcher),
            "ERC5164Hook: invalid dispatcher"
        );
        dispatcher = IMessageDispatcher(_dispatcher);
    }

    function _quoteDispatch(bytes calldata, bytes calldata)
        internal
        pure
        override
        returns (uint256)
    {
        revert("not implemented");
    }

    function _sendMessageId(
        bytes calldata,
        /* metadata */
        bytes memory payload
    ) internal override {
        require(msg.value == 0, "ERC5164Hook: no value allowed");
        dispatcher.dispatchMessage(destinationDomain, ism, payload);
    }
}
