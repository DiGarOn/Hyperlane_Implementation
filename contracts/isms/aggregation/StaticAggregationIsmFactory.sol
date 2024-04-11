// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// ============ Internal Imports ============
import {StaticThresholdAddressSetFactory} from "../../libs/StaticAddressSetFactory.sol";
import {StaticAggregationIsm} from "./StaticAggregationIsm.sol";

contract StaticAggregationIsmFactory is StaticThresholdAddressSetFactory {
    function _deployImplementation()
        internal
        virtual
        override
        returns (address)
    {
        return address(new StaticAggregationIsm());
    }
}
