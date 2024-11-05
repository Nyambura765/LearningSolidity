//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract SolidityTest {
   constructor() {
   }
   
   function getResult() public pure  returns(uint) {
    //this is a comment.
    /**
    this performs a basic addition arithmetics
    **/
      uint a = 1;
      uint b = 2;
      uint result = a + b;
      return result;
   }
}
