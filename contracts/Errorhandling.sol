//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract ControlledAccess {

    address public owner;
    uint public data;
    bool public isSet;

    constructor() {
        owner = msg.sender; // Set contract deployer as the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can execute this"); // Triggers error if not owner
        _;
    }

    function setData(uint _data) public onlyOwner {
        require(_data > 0, "Data must be positive"); // Error handling for invalid input
        data = _data;
        isSet = true;
    }

    function resetData() public onlyOwner {
        data = 0;
        isSet = false;
    }

    function getData() public view returns (uint) {
        require(isSet, "Data has not been set yet"); // Error handling if data is not set
        return data;
    }

    function multiplyData(uint _factor) public view returns (uint) {
        require(isSet, "Data must be set before multiplication"); // Check if data is set
        uint result = data * _factor;
        assert(result >= data); 
        return result;
    }

    // New function to demonstrate revert()
    function checkData(uint _value) public view {
        if (_value != data) {
            revert("Provided value does not match the stored data"); 
        }
    }
}