// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Approve {
    // emit these
    function main(address token, uint256 amount) external {
        assembly {
            // your code here
            // approve "token" to spend "amount"
            // hint: approve has function selector 0x095ea7b3 and signature "approve(address,uint256)"
            mstore(0x00, shl(224, 0x095ea7b3))
            mstore(0x04, token)
            mstore(0x24, amount)
            let result := call(gas(), token, 0, 0x00, 0x44, 0, 0)
            if iszero(result) {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
       }
    }
}

