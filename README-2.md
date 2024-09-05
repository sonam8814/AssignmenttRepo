# Solidity Contracts

This repository contains various Solidity smart contracts designed for different purposes. Below is a brief overview of each contract.

## Contracts Overview

### 1. SHA-256 Hash Contract

**File:** `SHA256Hash.sol`

This contract provides a function to hash an input string using the SHA-256 algorithm and check if the resulting hash starts with "00000".

#### Functions
- **`findHash(string memory input)`**: Computes the SHA-256 hash of the given input string.
- **`checkHash(string memory input)`**: Checks if the SHA-256 hash of the input string starts with "00000".

### 2. SHA-256 Hash Contract with Prefix

**File:** `SHA256HashWithPrefix.sol`

This contract extends the previous one by including a prefix `"devadnani26"` before hashing. It allows checking if the hash of the concatenated string starts with "00000".

#### Functions
- **`findHash(string memory input)`**: Computes the SHA-256 hash of the input string concatenated with the prefix `"devadnani26"`.
- **`checkHash(string memory input)`**: Checks if the SHA-256 hash of the concatenated string starts with "00000".

### 3. Nonce Finder Contract

**File:** `NonceFinder.sol`

This contract is designed to find a nonce that, when appended to a predefined message, produces a SHA-256 hash starting with "00000".

#### Functions
- **`findHashWithNonce(uint256 nonce)`**: Computes the SHA-256 hash of the predefined message concatenated with the given nonce.
- **`checkHashWithNonce(uint256 nonce)`**: Checks if the SHA-256 hash of the concatenated message and nonce starts with "00000".

### 4. Donation Smart Contract

**File:** `DonationContract.sol`

This contract allows individuals to donate Ether to different recipients and enables recipients to withdraw their donations.

#### Functions
- **`donate(address payable recipient)`**: Allows users to donate Ether to the specified recipient.
- **`withdraw()`**: Allows recipients to withdraw their donations.
- **`getContractBalance()`**: Returns the total Ether balance held by the contract.

#### Events
- **`Donation(address indexed donor, address indexed recipient, uint256 amount)`**: Logs details of each donation.

## Deployment and Usage

1. **Deploy Contracts**: Use tools like Remix, Truffle, or Hardhat to deploy the contracts.
2. **Interact with Contracts**: Use web3 or ethers.js libraries to interact with the deployed contracts.
3. **Security**: Ensure to follow best practices to avoid vulnerabilities.

## License

This project is licensed under the MIT License.

