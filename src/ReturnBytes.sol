// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnBytes {
    function main(address a, uint256 b) external pure returns (bytes memory) {
        assembly {
            // your code here
            // encode a and b `abi.encode(a,b)` and return it.
            let ptr := mload(0x40)
            mstore(ptr, 0x20) // offset
            mstore(add(ptr, 0x20), 0x40) // length
            mstore(add(ptr, 0x40), a)
            mstore(add(ptr, 0x60), b)
            return(ptr, 0x80)
        }
    }
}
