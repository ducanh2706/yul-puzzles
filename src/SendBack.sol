// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SendBack {

    fallback() external payable {
        assembly {
            // your code here
            // whatever amount of ether is sent to the contract, send it back to the sender
            // hint: use callvalue() to get the amount of ether sent to the contract
            let result := call(gas(), caller(), callvalue(), 0, 0, 0, 0)
            if iszero(result) {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
        }
    }
}