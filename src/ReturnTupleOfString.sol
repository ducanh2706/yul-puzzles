// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfString {
    function main() external pure returns (string memory, string memory) {
        assembly {
            // your code here
            // return the tuple of string: ("Hello", "RareSkills")
            let ptr := mload(0x40)
            mstore(ptr, 0x40) // offset of Hello
            mstore(add(ptr, 0x20), 0x80) // offset of Rareskills
            mstore(add(ptr, 0x40), 0x05) // length of Hello
            mstore(add(ptr, 0x60), shl(216, 0x48656c6c6f)) // Hello
            mstore(add(ptr, 0x80), 0x0a) // length of Rareskills
            mstore(add(ptr, 0xa0), shl(176, 0x52617265536b696c6c73)) // Rareskills
            return(ptr, 0xc0)
            // 0000000000000000000000000000000000000000000000000000000000000040
            // 0000000000000000000000000000000000000000000000000000000000000080
            // 0000000000000000000000000000000000000000000000000000000000000005
            // 48656c6c6f000000000000000000000000000000000000000000000000000000
            // 000000000000000000000000000000000000000000000000000000000000000a
            // 52617265536b696c6c7300000000000000000000000000000000000000000000
        }
    }
}
