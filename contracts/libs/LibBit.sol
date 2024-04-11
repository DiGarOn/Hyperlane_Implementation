// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Library for bit shifting and masking
library LibBit {
    function setBit(uint256 _value, uint256 _index)
        internal
        pure
        returns (uint256)
    {
        return _value | (1 << _index);
    }

    function clearBit(uint256 _value, uint256 _index)
        internal
        pure
        returns (uint256)
    {
        return _value & ~(1 << _index);
    }

    function isBitSet(uint256 _value, uint256 _index)
        internal
        pure
        returns (bool)
    {
        return (_value >> _index) & 1 == 1;
    }
}
