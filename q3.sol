// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FindNonce {
    string constant message = "Dev => Karan | Rs 100\nKaran => Darsh | Rs 10";

    function findHashWithNonce(uint256 nonce) public pure returns (bytes32) {
        // Concatenate the message with the nonce and hash it
        bytes32 hash = sha256(abi.encodePacked(message, nonce));
        return hash;
    }

    function checkHashWithNonce(uint256 nonce) public pure returns (bool) {
        // Concatenate the message with the nonce and hash it
        bytes32 hash = sha256(abi.encodePacked(message, nonce));

        // Check if the hash starts with 00000 (first 5 hex characters are 0)
        return uint256(hash) < 0x000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    }
}
