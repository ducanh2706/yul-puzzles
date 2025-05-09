// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AbsoluteValue{

  function main(int256 x) external pure returns (uint256) {
      assembly {
          // your code here
          // return the absolute value of x
          // hint: use signed comparisons
          // hint: https://www.rareskills.io/post/signed-int-solidity
          if slt(x, 0) {
            x := not(sub(x, 1))
          }

          mstore(0x00, x)
          return(0x00, 0x20)
      }
  }
}
