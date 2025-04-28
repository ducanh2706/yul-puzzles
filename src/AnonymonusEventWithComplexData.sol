// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AnonymonusEventWithComplexData {
    enum Gender {
        Male,
        Female,
        Trans
    }

    struct Person {
        string name;
        uint256 age;
        Gender gender;
    }

    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, Person person);

    function main(address emitter, bytes32 id, Person memory person) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,(string,uint256,uint8))` event.
            // Anonymous events don't have the event signature (topic0) included.
            // Hint: how the `Person` struct is encoded in mem:
            //          - string offset
            //          - string length offset
            //          - age
            //          - gender
            //          - name length
            //          - name
            let ptr := mload(0x40)
            let len := mload(mload(person))
            mstore(ptr, 0x20) // struct offset
            mstore(add(ptr, 0x20), 0x60) // string offset
            mstore(add(ptr, 0x40), mload(add(person, 0x20))) // age
            mstore(add(ptr, 0x60), mload(add(person, 0x40))) // gender
            mstore(add(ptr, 0x80), len) // length
            for {let i := 0} lt(i, len) {i := add(i, 0x20)} {
                mstore(add(ptr, add(0xa0, i)), mload(add(person, add(0x80, i))))
            }
            
            log3(ptr, add(0xa0, and(add(len, 0x1f), not(0x1f))), "", emitter, id)
            // and(add(len, 0x1f), not(0x1f)) is ceil(len) (divisible by 16)
        }
    }
}
