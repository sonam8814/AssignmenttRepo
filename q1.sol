
pragma solidity ^0.8.0;

contract FindHash {
    function findHash(string memory input) public pure returns (bytes32) {
        bytes32 hash = sha256(abi.encodePacked(input));
        return hash;
    }

    function checkHash(string memory input) public pure returns (bool) {
        bytes32 hash = sha256(abi.encodePacked(input)); 
              
        return uint256(hash) < 0x000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    }
}
