// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IInterchainSecurityModule} from "../interfaces/IInterchainSecurityModule.sol";

contract NoopIsm is IInterchainSecurityModule {
    uint8 public constant override moduleType = uint8(Types.NULL);

    function verify(bytes calldata, bytes calldata)
        public
        pure
        override
        returns (bool)
    {
        return true;
    }
}
