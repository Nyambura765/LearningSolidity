//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ControlledAccess {

    address public owner;
    uint public data;
    bool public isSet;

    constructor() {
        owner = msg.sender; // Set contract deployer as the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can execute this");
        _;
    }

    function setData(uint _data) public onlyOwner {
        data = _data;
        isSet = true;
    }

    function resetData() public onlyOwner {
        data = 0;
        isSet = false;
    }

    function getData() public view returns (uint) {
        return data;
    }

    function multiplyData(uint _factor) public view returns (uint) {
        return data * _factor;
    }
}
