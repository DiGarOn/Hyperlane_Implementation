// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {GasRouter} from "../client/GasRouter.sol";

contract TestGasRouter is GasRouter {
    constructor(address _mailbox) GasRouter(_mailbox) {}

    function dispatch(uint32 _destination, bytes memory _msg) external payable {
        _dispatch(_destination, _msg);
    }

    function _handle(
        uint32,
        bytes32,
        bytes calldata
    ) internal pure override {}
}
