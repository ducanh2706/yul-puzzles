// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // your code here
            // return the maximum value in the array
            // revert if array is empty
            let len := mload(arr)
            let ptr := add(arr, 0x20)

            let maxPtr := mload(0x40)
            mstore(maxPtr, mload(ptr))

            for {let i := ptr} lt(i, add(ptr, mul(len, 0x20))) {i := add(i, 0x20)} {
                if gt(mload(i), mload(maxPtr)) {
                    mstore(maxPtr, mload(i))
                }
            }

            return (maxPtr, 0x20)
        }
    }
}
