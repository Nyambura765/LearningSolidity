// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract UserInformation {

    struct User {
        string name;
        uint256 age;
        uint256 favoriteNumber;
    }

    
    mapping(address => User) public users;

    // Function to store User Data
    function storeUserData(string memory _name, uint256 _age, uint256 _favoriteNumber) public {
        users[msg.sender] = User({
            name: _name,
            age: _age,
            favoriteNumber: _favoriteNumber
        });
    }

    // Get user data using ABI encoding and decoding
    function getUserData(address _userAddress) public view returns (string memory, uint256, uint256) {
        User memory user = users[_userAddress];
          bytes memory encodedData = abi.encode(user.name, user.age, user.favoriteNumber);
        (string memory name, uint256 age, uint256 favoriteNumber) = abi.decode(encodedData, (string, uint256, uint256));

        return (name, age, favoriteNumber);
    }
}
