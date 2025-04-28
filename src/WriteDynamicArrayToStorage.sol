// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;
import {console} from "forge-std/console.sol";

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere`
            let pos := keccak256(0x00, 0x20)
            let len := x.length
            calldatacopy(0, x.offset, mul(len, 0x20))
            sstore(0, len)
            
            for {let i := 0} lt(i, len) {i := add(i, 1)} {
                sstore(add(pos, i), mload(mul(i, 0x20)))
            }
        }
    }
}
