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
import {IInterchainSecurityModule} from "../../interfaces/IInterchainSecurityModule.sol";
import {LibBit} from "../../libs/LibBit.sol";
import {Message} from "../../libs/Message.sol";



// ============ External Imports ============
import {Initializable} from "../../../libs/Initializable.sol";
import {Address} from "../../../libs/Address.sol";


/**
 * @title AbstractMessageIdAuthorizedIsm
 * @notice Uses external verfication options to verify interchain messages which need a authorized caller
 */
abstract contract AbstractMessageIdAuthorizedIsm is
    IInterchainSecurityModule,
    Initializable
{
    using Address for address payable;
    using LibBit for uint256;
    using Message for bytes;
    // ============ Public Storage ============

    /// @notice Maps messageId to whether or not the message has been verified
    /// first bit is boolean for verification
    /// rest of bits is the amount to send to the recipient
    /// @dev bc of the bit packing, we can only send up to 2^255 wei
    /// @dev the first bit is reserved for verification and the rest 255 bits are for the msg.value
    mapping(bytes32 => uint256) public verifiedMessages;
    /// @notice Index of verification bit in verifiedMessages
    uint256 public constant MASK_INDEX = 255;
    /// @notice Address for the authorized hook
    address public authorizedHook;

    // ============ Events ============

    /// @notice Emitted when a message is received from the external bridge
    event ReceivedMessage(bytes32 indexed messageId);

    // ============ Initializer ============

    function setAuthorizedHook(address _hook) external initializer {
        require(
            _hook != address(0),
            "AbstractMessageIdAuthorizedIsm: invalid authorized hook"
        );
        authorizedHook = _hook;
    }

    // ============ External Functions ============

    /**
     * @notice Verify a message was received by ISM.
     * @param message Message to verify.
     */
    function verify(
        bytes calldata,
        /*_metadata*/
        bytes calldata message
    ) external returns (bool) {
        bytes32 messageId = message.id();

        // check for the first bit (used for verification)
        bool verified = verifiedMessages[messageId].isBitSet(MASK_INDEX);
        // rest 255 bits contains the msg.value passed from the hook
        if (verified) {
            payable(message.recipientAddress()).sendValue(
                verifiedMessages[messageId].clearBit(MASK_INDEX)
            );
        }
        return verified;
    }

    /**
     * @notice Receive a message from the AbstractMessageIdAuthHook
     * @dev Only callable by the authorized hook.
     * @param messageId Hyperlane Id of the message.
     */
    function verifyMessageId(bytes32 messageId) external payable virtual {
        require(
            _isAuthorized(),
            "AbstractMessageIdAuthorizedIsm: sender is not the hook"
        );

        verifiedMessages[messageId] = msg.value.setBit(MASK_INDEX);
        emit ReceivedMessage(messageId);
    }

    function _isAuthorized() internal view virtual returns (bool);
}
