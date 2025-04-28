// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPackedDynamicArray64 {
    uint64[] public writeHere;

    function main(uint64 v1, uint64 v2, uint64 v3, uint64 v4, uint64 v5) external {
        assembly {
            // your code here
            // write the code to store v1, v2, v3, v4, and v5 in the `writeHere` array in sequential order.
            // Hint: `writeHere` is a dynamic array, so you will need to access its length and use `mstore` or `sstore`
            // appropriately to push new values into the array.
            let base := keccak256(0x00, 0x20)
            
            let packed0 := v4
            packed0 := or(shl(64, packed0), v3)
            packed0 := or(shl(64, packed0), v2)
            packed0 := or(shl(64, packed0), v1)
        
            sstore(writeHere.slot, 5)
            sstore(base, packed0)
            sstore(add(base, 1), v5)
        }
    }
}
