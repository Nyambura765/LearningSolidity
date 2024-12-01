// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WhitelistMint {
    address public owner; 
    mapping(address => bool) public hasMinted; 

    constructor() {
        owner = msg.sender;
    }
    event Minted(address indexed minter);

    function getMessageHash(address _minter) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_minter));
    }

     function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

     function verify(
        address _signer,
        address _minter,
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_minter);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return ecrecover(ethSignedMessageHash, _v, _r, _s) == _signer;
    }

     function mint(
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) external {
        require(!hasMinted[msg.sender], "Already minted!"); 
        require( verify(owner, msg.sender, _v, _r, _s),  "Invalid signature!" ); 
        
         hasMinted[msg.sender] = true; 
        emit Minted(msg.sender); 
    }
}
