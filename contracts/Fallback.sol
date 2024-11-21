// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedMarketplace {
    event FallbackCalled(address sender, uint amount, bytes data);
    event EtherReceived(address sender, uint amount);

    mapping(uint => uint) public productPrices; 

    // Function to set product prices
    function setProductPrice(uint productId, uint price) public {
        productPrices[productId] = price;
    }

    // Function to buy a product
    function buyProduct(uint productId) public payable {
        require(msg.value == productPrices[productId], "Incorrect payment amount");
        
    }

    // Receive function 
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    // Fallback function 
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }

    // Function to check the contract's balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
