// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// ============ Internal Imports ============
import {DomainRoutingIsm} from "./DomainRoutingIsm.sol";
import {MailboxClient} from "../../client/MailboxClient.sol";
import {EnumerableMapExtended} from "../../libs/EnumerableMapExtended.sol";
import {TypeCasts} from "../../libs/TypeCasts.sol";
import {IInterchainSecurityModule} from "../../interfaces/IInterchainSecurityModule.sol";
// ============ External Imports ============
import {Address} from "../../../libs/Address.sol";
contract DefaultFallbackRoutingIsm is DomainRoutingIsm, MailboxClient {
    using EnumerableMapExtended for EnumerableMapExtended.UintToBytes32Map;
    using Address for address;
    using TypeCasts for bytes32;

    constructor(address _mailbox) MailboxClient(_mailbox) {}

    function module(uint32 origin)
        public
        view
        override
        returns (IInterchainSecurityModule)
    {
        (bool contained, bytes32 _module) = _modules.tryGet(origin);
        if (contained) {
            return IInterchainSecurityModule(_module.bytes32ToAddress());
        } else {
            return mailbox.defaultIsm();
        }
    }
}


// File contracts/libs/MinimalProxy.sol

pragma solidity >=0.6.11;

// Library for building bytecode of minimal proxies (see https://eips.ethereum.org/EIPS/eip-1167)
library MinimalProxy {
    bytes20 private constant PREFIX =
        hex"3d602d80600a3d3981f3363d3d373d3d3d363d73";
    bytes15 private constant SUFFIX = hex"5af43d82803e903d91602b57fd5bf3";

    function create(address implementation) internal returns (address proxy) {
        bytes memory _bytecode = bytecode(implementation);
        assembly {
            proxy := create(0, add(_bytecode, 32), mload(_bytecode))
        }
    }

    function bytecode(address implementation)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(PREFIX, bytes20(implementation), SUFFIX);
    }
}
