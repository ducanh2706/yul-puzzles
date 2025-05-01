// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BasicBank {
    // emit these
    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    error InsufficientBalance();

    mapping(address => uint256) public balances;

    function deposit() external payable {
        bytes32 depositSelector = Deposit.selector;
        assembly {
            // emit Deposit(msg.sender, msg.value)
            // increment the balance of the msg.sender by msg.value
            mstore(0x00, callvalue())
            log2(0x00, 0x20, depositSelector, caller())

            mstore(0x00, caller())
            mstore(0x20, 0x00)
            let pos := keccak256(0x00, 0x40)
            sstore(pos, callvalue())
        }
    }

    function withdraw(uint256 amount) external returns (uint256 bal) {
        bytes32 withdrawSelector = Withdraw.selector;
        bytes4 insufficientBalanceSelector = InsufficientBalance.selector;
        assembly {
            // emit Withdraw(msg.sender, amount)
            mstore(0x00, amount)
            log2(0x00, 0x20, withdrawSelector, caller())
            // if the balance is less than amount, revert InsufficientBalance()
            mstore(0x00, caller())
            mstore(0x20, 0x00)
            let pos := keccak256(0x00, 0x40)
            bal := sload(pos)
            if lt(bal, amount) {
                mstore(0x00, insufficientBalanceSelector)
                revert(0x00, 0x04)
            }

            // decrement the balance of the msg.sender by amount
            bal := sub(bal, amount)
            // send the amount to the msg.sender
            sstore(pos, bal)
        }
    }
}

