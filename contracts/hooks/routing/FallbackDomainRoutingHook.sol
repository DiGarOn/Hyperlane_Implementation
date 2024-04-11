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

import {DomainRoutingHook} from "./DomainRoutingHook.sol";
import {Message} from "../../libs/Message.sol";
import {IPostDispatchHook} from "../../interfaces/hooks/IPostDispatchHook.sol";



/**
 * @title FallbackDomainRoutingHook
 * @notice Delegates to a hook based on the destination domain of the message.
 * If no hook is configured for the destination domain, delegates to a fallback hook.
 */
contract FallbackDomainRoutingHook is DomainRoutingHook {
    using Message for bytes;

    IPostDispatchHook public immutable fallbackHook;

    constructor(
        address _mailbox,
        address _owner,
        address _fallback
    ) DomainRoutingHook(_mailbox, _owner) {
        fallbackHook = IPostDispatchHook(_fallback);
    }

    // ============ Internal Functions ============

    function _getConfiguredHook(bytes calldata message)
        internal
        view
        override
        returns (IPostDispatchHook hook)
    {
        hook = hooks[message.destination()];
        if (address(hook) == address(0)) {
            hook = fallbackHook;
        }
    }
}
