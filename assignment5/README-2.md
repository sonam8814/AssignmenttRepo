# Solidity Smart Contracts

This repository contains two smart contracts implemented in Solidity:
1. **Crowdfunding Platform**: A decentralized platform where users can create, contribute to, and finalize crowdfunding campaigns.
2. **Voting System**: A decentralized voting system where participants can create proposals, vote, and view the winning proposal.

---

## Crowdfunding Platform

### Description
The crowdfunding platform allows users to create campaigns with a target amount and a deadline. Participants can contribute funds, and the contract tracks the total contributions. If the campaign reaches its target by the deadline, the funds are released to the campaign creator; otherwise, contributors can withdraw their contributions.

### Features
- **Create Campaign**: Users can create a new crowdfunding campaign with a goal amount and deadline.
- **Contribute to Campaign**: Participants can contribute Ether to any active campaign before the deadline.
- **Finalize Campaign**: Once the deadline passes, if the target is met, the funds are transferred to the creator. If not, contributors can withdraw their funds.
- **Withdraw Contributions**: If a campaign fails to reach its target, contributors can withdraw their contributions.

### Functions
- `createCampaign(uint _goalAmount, uint _durationInDays)`: Create a new campaign.
- `contribute(uint campaignId)`: Contribute to a specific campaign.
- `finalizeCampaign(uint campaignId)`: Finalize the campaign, releasing funds to the creator if successful.
- `withdraw(uint campaignId)`: Withdraw contributions if the campaign fails.

### Events
- `CampaignCreated(uint campaignId, address creator, uint goalAmount, uint deadline)`: Triggered when a campaign is created.
- `ContributionMade(uint campaignId, address contributor, uint amount)`: Triggered when a contribution is made.
- `CampaignFinalized(uint campaignId, bool success)`: Triggered when a campaign is finalized.
- `FundsWithdrawn(uint campaignId, address contributor, uint amount)`: Triggered when a contributor withdraws their funds.

---

## Voting System

### Description
The voting system allows users to propose new options and cast votes. Each address can vote only once per proposal. The contract can also determine the winning proposal based on the highest number of votes.

### Features
- **Create Proposal**: Users can add new proposals.
- **Cast Vote**: Users can vote for any existing proposal. Each user can vote only once.
- **View Proposal Vote Count**: Check how many votes a proposal has received.
- **Determine Winning Proposal**: Identify the proposal with the highest number of votes.

### Functions
- `createProposal(string memory proposalName)`: Create a new proposal with a name.
- `vote(uint proposalId)`: Cast a vote for a proposal by its ID.
- `getProposalVoteCount(uint proposalId)`: View the current number of votes for a specific proposal.
- `determineWinningProposal()`: Returns the winning proposal based on the highest vote count.

### Events
- `ProposalCreated(string name, uint proposalId)`: Triggered when a new proposal is created.
- `VoteCast(address voter, uint proposalId)`: Triggered when a vote is cast.
- `WinningProposalDetermined(uint winningProposalId, string name, uint voteCount)`: Triggered when the winning proposal is determined.

---
