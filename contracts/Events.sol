//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract ERC20Token {
    mapping(address => uint256) public balances;

    // Event for transfers
    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
         balances[msg.sender] = 1000000;
    }

    function transfer(address _to, uint256 _value) public {
        require(balances[msg.sender] >= _value, "Insufficient balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;

        // Emit the transfer event
        emit Transfer(msg.sender, _to, _value);
    }
}
