// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {TestRecipient} from "./TestRecipient.sol";

contract LightTestRecipient is TestRecipient {
    // solhint-disable-next-line no-empty-blocks
    function handle(
        uint32 _origin,
        bytes32 _sender,
        bytes calldata _data
    ) external payable override {
        // do nothing
    }
}
