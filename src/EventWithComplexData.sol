// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;
import {console} from "forge-std/console.sol";
contract EventWithComplexData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, address[] players, uint256[] scores);

    function main(address emitter, address[] memory players, uint256[] memory scores) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,address[],uint256[])` event
            // Hint: Use `log2` to emit the event with the hash as the topic0 and `emitter` as topic1, then the data
            let ptr := mload(0x40)
            let playersLen := mload(players)
            let scoresLen := mload(scores)
            let scoresOffset := add(0x60, mul(playersLen, 0x20))
            mstore(ptr, 0x40) // offset of players
            mstore(add(ptr, 0x20), scoresOffset) // offset of scores
            mstore(add(ptr, 0x40), playersLen)

            for {let i := 0} lt(i, playersLen) {i := add(i, 1)} {
                mstore(add(add(ptr, 0x60), mul(i, 0x20)), mload(add(players, mul(add(i, 1), 0x20))))
            }

            mstore(add(ptr, scoresOffset), scoresLen)
            for {let i := 0} lt(i, scoresLen) {i := add(i, 1)} {
                mstore(add(add(add(ptr, scoresOffset), 0x20), mul(i, 0x20)), mload(add(scores, mul(add(i, 1), 0x20))))
            }
            let data_size := mul(add(playersLen, add(scoresLen, 4)), 0x20)
            log2(ptr, data_size, 0x06af3d8f9866c9f54dcf425d9da9f75849af90454a25bca9df5fb24d80683e6a, emitter)
        }
    }
}
