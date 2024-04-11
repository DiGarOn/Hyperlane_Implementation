// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// ============ Internal Imports ============
import {AbstractRoutingIsm} from "./AbstractRoutingIsm.sol";
import {IMailbox} from "../../interfaces/IMailbox.sol";
import {IInterchainSecurityModule} from "../../interfaces/IInterchainSecurityModule.sol";
import {InterchainAccountMessage} from "../../middleware/libs/InterchainAccountMessage.sol";
import {Message} from "../../libs/Message.sol";
/**
 * @title InterchainAccountIsm
 */
contract InterchainAccountIsm is AbstractRoutingIsm {
    IMailbox private immutable mailbox;

    // ============ Constructor ============
    constructor(address _mailbox) {
        mailbox = IMailbox(_mailbox);
    }

    // ============ Public Functions ============

    /**
     * @notice Returns the ISM responsible for verifying _message
     * @param _message Formatted Hyperlane message (see Message.sol).
     * @return module The ISM to use to verify _message
     */
    function route(bytes calldata _message)
        public
        view
        virtual
        override
        returns (IInterchainSecurityModule)
    {
        address _ism = InterchainAccountMessage.ism(Message.body(_message));
        if (_ism == address(0)) {
            return mailbox.defaultIsm();
        } else {
            return IInterchainSecurityModule(_ism);
        }
    }
}
