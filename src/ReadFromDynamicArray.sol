// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArray {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Assume `index` is <= to the length of readMe
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let ptr := mload(0x40)
            mstore(ptr, readMe.slot)
            let startPos := keccak256(ptr, 0x20)
            
            mstore(ptr, sload(add(startPos, index)))
            return(ptr, 0x20)
        }
    }
}
