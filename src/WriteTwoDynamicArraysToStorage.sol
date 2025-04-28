// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`
            let posX := keccak256(0x00, 0x20)
            sstore(0, x.length)
            for {let i := 0} lt(i, x.length) {i := add(i, 1)} {
                sstore(add(posX, i), calldataload(add(x.offset, mul(i, 0x20))))
            }

            mstore(0x00, 0x01)
            let posY := keccak256(0x00, 0x20)
            sstore(1, y.length)
            for {let i := 0} lt(i, y.length) {i := add(i, 1)} {
                sstore(add(posY, i), calldataload(add(y.offset, mul(i, 0x20))))
            }
            
        }
    }
}
