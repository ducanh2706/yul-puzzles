// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    function main(uint256 x) external pure returns (bool) {
        assembly {
            // your code here
            // return true if x is a prime number, else false
            // 1. check if the number is a multiple of 2 or 3
            // 2. loop from 5 to x / 2 to see if it is divisible
            // 3. increment the loop by 2 to skip the even numbers
            
            mstore(0x00, 0x00)

            if lt(x, 0x02) {
                return(0x00, 0x20)
            }

            if or(eq(mod(x, 0x02), 0), eq(mod(x, 0x03), 0)) {
                return(0x00, 0x20)
            }

            for {let i := 0x05} lt(i, add(div(x, 0x02), 0x01)) {i := add(i, 0x01)} {
                if iszero(mod(x, i)) {
                    return(0x00, 0x20)
                }
            }

            mstore(0x00, 0x01)
            return(0x00, 0x20)
        }
    }
}
