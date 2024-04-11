// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Indexed {
    uint256 public immutable deployedBlock;

    constructor() {
        deployedBlock = block.number;
    }
}