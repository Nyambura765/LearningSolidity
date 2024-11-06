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
//solidity variables
/** 1.state variable=variables stored on the blockchain
   2.local variables= defined inside the function and only accessible during the function execution
     3.global variables= are special variables provided by solidity that contain information
about the blockchain and the current transactions
**/



contract VariableExamples {
    // State variable (stored on the blockchain)
    uint public stateVariable = 100;

    // Constant variable (cannot be modified after declaration)
    uint public constant CONSTANT_VARIABLE = 50;

    // Public variable - automatically creates a getter
    address public owner;

    // Constructor to set the owner address (another state variable)
    constructor() {
        owner = msg.sender; // Global variable `msg.sender` refers to the address calling the contract
    }

    // Function to demonstrate local variables and global variables
    function sumWithConstant(uint number) public view returns (uint) {
        // Local variable (only accessible within this function)
        uint localVariable = 10;

        // Using global variable `block.timestamp` to show the current block timestamp
        uint currentTimestamp = block.timestamp;

        // Returning the sum of local, state, and constant variables
        return localVariable + stateVariable + CONSTANT_VARIABLE + number + currentTimestamp;
    }
}

//visiblity modifiers=they define how and where a function or variable can be accessed.
/** 1.public= accessible by any contract
    2.External= can only be called from the outside of the contract and cannot be called
    internally without using (this)
    3.Internal= only accessible within the contract and by derived contracts(inherited contracts)
    4.Private= Accessible only within the contract where it is declared.
**/


contract VisibilityModifiers {
    uint public publicVariable = 10;     // Accessible both inside and outside of the contract
    uint internal internalVariable = 20; // Accessible within the contract and derived contracts
    uint private privateVariable = 30;   // Only accessible within this contract

    // Public function: accessible internally and externally
    function publicFunction() public view returns (uint) {
        return publicVariable;
    }

    // Internal function: accessible within this contract and derived contracts
    function internalFunction() internal view returns (uint) {
        return internalVariable;
    }

    // Private function: only accessible within this contract
    function privateFunction() private view returns (uint) {
        return privateVariable;
    }

    // External function: only callable from outside the contract
    function externalFunction() external view returns (uint) {
        return publicVariable;
    }

    // Function demonstrating calling of visibility-specific functions internally
    function testVisibility() public view returns (uint) {
        uint sum = publicFunction();       // Calling public function internally
        sum += internalFunction();         // Calling internal function
        // sum += privateFunction();       // Can call private function internally
        // sum += externalFunction();      // ERROR: Cannot call external function internally
        return sum;
    }
}

contract Derived is VisibilityModifiers {
    function getInternalVariable() public view returns (uint) {
        return internalFunction();  // Can access internal function from parent contract
    }
}


