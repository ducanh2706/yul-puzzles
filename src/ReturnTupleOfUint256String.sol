// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfUint256String {
    function main() external pure returns (uint256, string memory) {
        assembly {
            // your code here
            // return the tuple of (uint256 and string): (420, "RareSkills")
            mstore(0x00, 420)
            mstore(0x20, 0x40) // offset of Rareskills
            mstore(0x40, 0x0a) // length of stirng
            mstore(0x60, shl(176, 0x52617265536b696c6c73))
            return(0x00, 0x80)
        }
    }
}
