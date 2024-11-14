//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


// Base contract for access control
contract AccessControl {
    mapping(address => bool) public isAdmin;

    constructor() {
         isAdmin[msg.sender] = true;
    }

    function addAdmin(address _admin) public virtual {
         require(isAdmin[msg.sender], "Not authorized");
        isAdmin[_admin] = true;
    }

    function removeAdmin(address _admin) public virtual {
        require(isAdmin[msg.sender], "Not authorized");
        isAdmin[_admin] = false;
    }
}

// Base contract for user management
contract UserManagement {
    mapping(address => bool) public isUser;

    function addUser(address _user) public virtual {
        isUser[_user] = true;
    }

    function removeUser(address _user) public virtual {
        isUser[_user] = false;
    }
}

// Derived contract that inherits from both AccessControl and UserManagement
contract AdminControl is AccessControl, UserManagement {
    // Override the addAdmin function from AccessControl
    function addAdmin(address _admin) public override {
        super.addAdmin(_admin); 
        addUser(_admin); 
    }

    // Override the removeAdmin function from AccessControl
    function removeAdmin(address _admin) public override {
        super.removeAdmin(_admin); 
        removeUser(_admin); 
    }

    // Override addUser function to restrict it to admins only
    function addUser(address _user) public override {
        require(isAdmin[msg.sender], "Only admins can add users");
        super.addUser(_user); 
    }

    // Function to check if an address is both an admin and a user
    function isAdminAndUser(address _addr) public view returns (bool) {
        return isAdmin[_addr] && isUser[_addr];
    }
}
