// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        // revert("RevertRevert");
        assembly {
            // revert the function with an error of type `Error(string)`
            // use "RevertRevert" as error message
            // Hint: The error type is a predefined four bytes. See https://www.rareskills.io/post/try-catch-solidity
            mstore(0x00, 0x08c379a0) // 0x08c379a0 = bytes4(keccak256(Error(string)))
            mstore(0x20, 0x20) // offset
            mstore(0x40, 0x0c) // length
            mstore(0x60, shl(0xa0, 0x526576657274526576657274)) // RevertRevert
            revert(0x1c, 0x50) // 0x04 (func selector) + 0x20 (offset) + 0x20 (length) + 0xc0 (length of string)
        }
    }
}
