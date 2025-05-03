// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Log2 {

    function main(uint256 x) external pure returns (uint256) {
        assembly {
            // your code here
            // return log2 of x rounded down
            // revert if x is 0
            // hint: log2 is the index of the highest bit that is set in x
            // for example:
            //   bin(1) = 0001, so log2(2) = 0
            //   bin(2) = 0010, so log2(2) = 1
            //   bin(3) = 0011, so log2(3) = 1
            //   bin(4) = 0100, so log2(4) = 2
            //   bin(5) = 0101, so log2(5) = 2
            //   bin(6) = 0110, so log2(6) = 2
            //   bin(7) = 0111, so log2(6) = 2
            //   bin(8) = 1000, so log2(6) = 3
            if iszero(x) {
                revert(0x00, 0x00)
            }

            let res := 0
            if gt(x, 0xffffffffffffffffffffffffffffffff) {
                x := shr(128, x)
                res := add(res, 128)
            }
            if gt(x, 0xffffffffffffffff) {
                x := shr(64, x)
                res := add(res, 64)
            }
            if gt(x, 0xffffffff) {
                x := shr(32, x)
                res := add(res, 32)
            }
            if gt(x, 0xffff) {
                x := shr(16, x)
                res := add(res, 16)
            }
            if gt(x, 0xff) {
                x := shr(8, x)
                res := add(res, 8)
            }
            if gt(x, 0x0f) {
                x := shr(4, x)
                res := add(res, 4)
            }
            if gt(x, 0x03) {
                x := shr(2, x)
                res := add(res, 2)
            }
            if gt(x, 0x01) {
                x := shr(1, x)
                res := add(res, 1)
            }

            mstore(0x00, res)
            return(0x00, 0x20)
        }
    }
}
