// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CrossChainEnabled} from "./CrossChainEnabled.sol";
import {LibOptimism} from "./LibOptimism.sol";

/**
 * @dev https://www.optimism.io/[Optimism] specialization or the
 * {CrossChainEnabled} abstraction.
 *
 * The messenger (`CrossDomainMessenger`) contract is provided and maintained by
 * the optimism team. You can find the address of this contract on mainnet and
 * kovan in the https://github.com/ethereum-optimism/optimism/tree/develop/packages/contracts/deployments[deployments section of Optimism monorepo].
 *
 * _Available since v4.6._
 */
abstract contract CrossChainEnabledOptimism is CrossChainEnabled {
    /// @custom:oz-upgrades-unsafe-allow state-variable-immutable
    address private immutable _messenger;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor(address messenger) {
        _messenger = messenger;
    }

    /**
     * @dev see {CrossChainEnabled-_isCrossChain}
     */
    function _isCrossChain() internal view virtual override returns (bool) {
        return LibOptimism.isCrossChain(_messenger);
    }

    /**
     * @dev see {CrossChainEnabled-_crossChainSender}
     */
    function _crossChainSender() internal view virtual override onlyCrossChain returns (address) {
        return LibOptimism.crossChainSender(_messenger);
    }
}
