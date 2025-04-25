// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleRevert {

  function main() external pure {
      assembly {
          // your code here
          // revert with no message
          revert(0x0, 0x0)
          // hint: https://www.rareskills.io/post/assembly-revert
      }
  }
}
