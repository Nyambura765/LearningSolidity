// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

contract SupplyChain {
    struct Item {
        bytes32 id;
        string name;
        uint256 quantity;
        address owner;
    }

    mapping(bytes32 => Item) public items;

    event ItemCreated(bytes32 id, string name, uint256 quantity, address owner);

    function createItem(string memory name, uint256 quantity) public {
        // Generate a unique ID using keccak256
        bytes32 itemId = keccak256(abi.encodePacked(name, quantity, msg.sender, block.timestamp));
         require(items[itemId].id == bytes32(0), "Item already exists");
        items[itemId] = Item(itemId, name, quantity, msg.sender);   

        emit ItemCreated(itemId, name, quantity, msg.sender);
    }

    function getItem(bytes32 itemId) public view returns (Item memory) {
        require(items[itemId].id != bytes32(0), "Item does not exist");
        return items[itemId];
    }
}
