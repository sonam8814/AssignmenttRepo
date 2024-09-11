// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Proposal {
        string name;  // Name of the proposal
        uint voteCount;  // Number of votes received
    }

    struct Voter {
        bool hasVoted;  // If true, that person has already voted
        uint votedProposalId;  // ID of the voted proposal
    }

    Proposal[] public proposals;  // Array to store proposals
    mapping(address => Voter) public voters;  // Mapping to store voter information

    event ProposalCreated(string name, uint proposalId);
    event VoteCast(address voter, uint proposalId);
    event WinningProposalDetermined(uint winningProposalId, string name, uint voteCount);

    modifier hasNotVoted() {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        _;
    }

    // Add a new proposal
    function createProposal(string memory proposalName) external {
        proposals.push(Proposal({
            name: proposalName,
            voteCount: 0
        }));

        emit ProposalCreated(proposalName, proposals.length - 1);
    }

    // Cast a vote for a specific proposal by ID
    function vote(uint proposalId) external hasNotVoted {
        require(proposalId < proposals.length, "Invalid proposal ID");

        // Mark the voter as having voted and store the voted proposal ID
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedProposalId = proposalId;

        // Increase the vote count of the selected proposal
        proposals[proposalId].voteCount += 1;

        emit VoteCast(msg.sender, proposalId);
    }

    // Get the current vote count of a specific proposal by ID
    function getProposalVoteCount(uint proposalId) external view returns (uint) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        return proposals[proposalId].voteCount;
    }

    // Determine the winning proposal based on the highest vote count
    function determineWinningProposal() external view returns (uint winningProposalId, string memory name, uint voteCount) {
        uint winningVoteCount = 0;
        uint winnerId = 0;

        // Loop through the proposals to find the one with the highest vote count
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winnerId = i;
            }
        }

        return (winnerId, proposals[winnerId].name, proposals[winnerId].voteCount);
    }
}

