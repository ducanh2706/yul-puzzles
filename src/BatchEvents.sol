// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BatchEvents {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(address[] memory emitters, bytes32[] memory ids, uint256[] memory nums) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,uint256)` event
            // Assuming all arrays (emitters, ids, and nums) are of equal length.
            // iterate over the set of parameters and emit events based on the array length.
            let len := mload(emitters)
            let stNum := add(nums, 0x20)
            let stEmit := add(emitters, 0x20)
            let stId := add(ids, 0x20)
            for {let i := 0} lt(i, len) {i := add(i, 1)} {
                let offset := mul(i, 0x20)
                log3(add(stNum, offset), 0x20, 0x044d482819499c9d5fde1245ce63873b1259fc52fc78651ccdcdf7392637d374, mload(add(stEmit, offset)), mload(add(stId, offset)))
            }
        }
    }
}
