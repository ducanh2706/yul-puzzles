// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDoubleMapping {
    mapping(address user => mapping(address token => uint256 value)) public balances;

    function main(address user, address token, uint256 value) external {
        assembly {
            // your code here
            // set the `value` for a `user` and a `token`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            mstore(0x00, user)
            mstore(0x20, 0x00)
            let userPos := keccak256(0x00, 0x40)
            mstore(0x00, token)
            mstore(0x20, userPos)
            let balancePos := keccak256(0x00, 0x40)
            sstore(balancePos, value)
        }
    }
}
