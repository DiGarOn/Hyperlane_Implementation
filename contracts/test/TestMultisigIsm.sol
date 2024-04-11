// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IMultisigIsm} from "../interfaces/isms/IMultisigIsm.sol";
import {IInterchainSecurityModule} from "../interfaces/IInterchainSecurityModule.sol";

contract TestMultisigIsm is IMultisigIsm {
    // solhint-disable-next-line const-name-snakecase
    uint8 public constant moduleType =
        uint8(IInterchainSecurityModule.Types.MERKLE_ROOT_MULTISIG);

    bool public accept;

    constructor() {
        accept = true;
    }

    function validatorsAndThreshold(bytes calldata)
        external
        pure
        returns (address[] memory, uint8)
    {
        address[] memory validators = new address[](1);
        validators[0] = address(0);
        return (validators, 1);
    }

    function setAccept(bool _val) external {
        accept = _val;
    }

    function verify(bytes calldata, bytes calldata)
        external
        view
        returns (bool)
    {
        return accept;
    }
}
