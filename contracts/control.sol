//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

//control structures in solidity-used to achieve decision making in code
/**
1.conditional statements=if,if-else,else-if statements
2.loops-for,while,do-whlie loops
**/

contract FunctionDemo {
    
    uint public storedResult;

    // Function to check if a number is even or odd using an if-else statement
    function isEven(uint number) public pure returns (string memory) {
        if (number % 2 == 0) {
            return "Even";
        } else {
            return "Odd";
        }
    }

    // Function to calculate the sum of numbers up to `n` using a for loop
    function sumUpTo(uint n) public pure returns (uint) {
        uint sum = 0;
        for (uint i = 1; i <= n; i++) {
            sum += i;
        }
        return sum;
    }

    // Function to find the first even number in an array using a for loop and break
    function findFirstEven(uint[] memory numbers) public pure returns (uint) {
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                return numbers[i]; // Exit the loop when an even number is found
            }
        }
        return 0; // Return 0 if no even number is found
    }

    // Function to sum only non-zero numbers in an array using a for loop and continue
    function sumNonZero(uint[] memory numbers) public pure returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] == 0) {
                continue;
            }
            sum += numbers[i];
        }
        return sum;
    }

    // Function to count down from a given number using a while loop
    function countDown(uint start) public pure returns (uint) {
        uint count = start;
        while (count > 0) {
            count--; 
        }
        return count; 
    }

    // Function to store the sum of numbers up to `n` in the state variable
    function storeSum(uint n) public {
        storedResult = sumUpTo(n); 
    }
}

