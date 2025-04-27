// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PushToDynamicArray {
    uint256[] pushToMe = [23, 4, 19, 3, 44, 88];

    function main(uint256 newValue) external {
        assembly {
            // your code here
            // push the newValue to the dynamic array `pushToMe`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let arrLen := sload(0)
            let ptr := mload(0x40)
            let newPos := add(keccak256(ptr, 0x20), arrLen)
            sstore(newPos, newValue)
            sstore(0, add(arrLen, 1))
        }
    }

    function getter() external view returns (uint256[] memory) {
        return pushToMe;
    }
}
