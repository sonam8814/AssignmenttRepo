// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonationContract {
    // Event to log donations
    event Donation(address indexed donor, address indexed recipient, uint256 amount);

    // Mapping to track total donations received by each recipient
    mapping(address => uint256) public donations;

    // Function to donate Ether to a specific recipient
    function donate(address payable recipient) public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");

        // Update the recipient's donation balance
        donations[recipient] += msg.value;

        // Emit the donation event
        emit Donation(msg.sender, recipient, msg.value);
    }

    // Function for the recipient to withdraw their donations
    function withdraw() public {
        uint256 amount = donations[msg.sender];
        require(amount > 0, "No donations available to withdraw");

        // Reset the donation balance before sending to avoid reentrancy attacks
        donations[msg.sender] = 0;

        // Transfer the donations to the recipient
        payable(msg.sender).transfer(amount);
    }

    // Function to check contract balance (total donations held)
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
