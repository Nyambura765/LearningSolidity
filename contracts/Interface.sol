// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the interface
interface IAccessControl {
    function grantRole(bytes32 role, address account) external;
    function revokeRole(bytes32 role, address account) external;
    function hasRole(bytes32 role, address account) external view returns (bool);
}

// Implementing access control functionality
contract AccessControl is IAccessControl {
    mapping(bytes32 => mapping(address => bool)) private _roles;

    // Define roles as constants
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN");
    bytes32 public constant USER_ROLE = keccak256("USER");

    // Modifier to restrict access to only accounts with a specific role
    modifier onlyRole(bytes32 role) {
        require(hasRole(role, msg.sender), "AccessControl: Access denied");
        _;
    }

    // Grant a role to an account
    function grantRole(bytes32 role, address account) external override onlyRole(ADMIN_ROLE) {
        _roles[role][account] = true;
    }

    // Revoke a role from an account
    function revokeRole(bytes32 role, address account) external override onlyRole(ADMIN_ROLE) {
        _roles[role][account] = false;
    }

    // Check if an account has a specific role
    function hasRole(bytes32 role, address account) public view override returns (bool) {
        return _roles[role][account];
    }
}
