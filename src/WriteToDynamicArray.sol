// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // your code here
            // store the values in the DYNAMIC array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let len := mload(x) 
            let startPos := keccak256(0x00, 0x20)
            let dataOffset := add(x, 0x20)

            sstore(0x00, len)

            for {let i := 0} lt(i, len) {i := add(i, 1)} {
                sstore(add(startPos, i), mload(add(dataOffset, mul(i, 0x20))))
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
