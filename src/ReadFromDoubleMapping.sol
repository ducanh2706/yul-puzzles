// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDoubleMapping {
    mapping(address user => mapping(address token => uint256)) public balances;

    function setValue(address user, address token, uint256 value) external {
        balances[user][token] = value;
    }

    function main(address user, address token) external view returns (uint256) {
        assembly {
            // your code here
            // read and return the `token` balance of `user` in the double mapping `balances`
            mstore(0x00, user)
            mstore(0x20, 0x00)
            let userPos := keccak256(0x00, 0x40)
            mstore(0x00, token)
            mstore(0x20, userPos)
            let balancePos := keccak256(0x00, 0x40)
            mstore(0x00, sload(balancePos))
            return(0x00, 0x20)
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }
}
