// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SquareRoot {
    function main(uint256 x) external pure returns (uint256) {
        // ref https://github.com/Uniswap/solidity-lib/blob/master/contracts/libraries/Babylonian.sol
        assembly {
            // your code here
            // return the square root of x rounded down
            // e.g. root(4) = 2 root(5) = 2 root(6) = 2, ..., root(8) = 2, root(9) = 3
            // hint: https://www.youtube.com/watch?v=CnMBo5nG_zk
            // hint: use x / 2 as initial guess
            // hint: be careful of overflow
            // hint: use a switch statement to handle 0, 1, and the general case
            // hint: use break to exit the loop if the new guess is the same as the old guess
            if iszero(xor(x, 1)) {
                mstore(0x00, 1)
                return(0x00, 0x20)
            }

            let t := div(x, 2)

            for {} true {} {
                let oth := div(x, t)
                
                if gt(t, oth) {
                    t := xor(t, oth) 
                    oth := xor(t, oth) 
                    t := xor(t, oth)
                }

                switch sub(oth, t) 
                case 0 {
                    mstore(0x00, t)
                    return(0x00, 0x20)
                }
                case 1 {
                    mstore(0x00, t)
                    return(0x00, 0x20)
                }
                default {
                    let average := div(add(oth, t), 2)
                    t := average
                }
            }
        }
    }
}