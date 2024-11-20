// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Importing a library
//import "./MathLibrary.sol";

contract MainContract {
    function calculateSum(uint a, uint b) public pure returns (uint) {
        return add(a, b); // Using the imported library function
    }
}
