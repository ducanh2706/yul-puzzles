// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimpleCalldata {
    function main(bytes calldata deploymentBytecode) external returns (address) {
        assembly {
            // your code here
            // create a contract using the deploymentBytecode
            // return the address of the contract
            // hint: use the `create` opcode
            // hint: use calldatacopy to copy the deploymentBytecode to memory
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let addr := create(0, add(ptr, 0x44), mload(add(ptr, 0x24)))
            mstore(0x00, addr)
            return(0x00, 0x20)
       }
    }
}