// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*@@@@@@@       @@@@@@@@@
 @@@@@@@@@       @@@@@@@@@
  @@@@@@@@@       @@@@@@@@@
   @@@@@@@@@       @@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@
     @@@@@  HYPERLANE  @@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@
   @@@@@@@@@       @@@@@@@@@
  @@@@@@@@@       @@@@@@@@@
 @@@@@@@@@       @@@@@@@@@
@@@@@@@@@       @@@@@@@@*/

// ============ Internal Imports ============
import {StaticAddressSetFactory} from "../../libs/StaticAddressSetFactory.sol";
import {StaticAggregationHook} from "./StaticAggregationHook.sol";

contract StaticAggregationHookFactory is StaticAddressSetFactory {
    function _deployImplementation()
        internal
        virtual
        override
        returns (address)
    {
        return address(new StaticAggregationHook());
    }
}
