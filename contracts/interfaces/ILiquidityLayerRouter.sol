// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface ILiquidityLayerRouter {
    function dispatchWithTokens(
        uint32 _destinationDomain,
        bytes32 _recipientAddress,
        address _token,
        uint256 _amount,
        string calldata _bridge,
        bytes calldata _messageBody
    ) external returns (bytes32);
}
