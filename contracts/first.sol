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
    /** prinitive datatypes in solidity are
    1.Boolean=true or false values
    2.uint=unsigned integers whicha are basically non negative numbers
      uint8
      uint16
      uint256
    3.int=integer which are basically negative numbers
       int8
       int16
       int256
    4.Adress=holds the 20 byte value representing the size of an Ethereum address.
    **/
      uint a = 1;
      uint b = 2;
      uint result = a + b;
      return result;
   }
}
