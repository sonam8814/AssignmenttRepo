// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    struct Campaign {
        address payable creator;
        uint goalAmount;
        uint deadline;
        uint totalContributed;
        bool isFinalized;
        mapping(address => uint) contributions;
    }

    mapping(uint => Campaign) public campaigns;
    uint public campaignCount;

    event CampaignCreated(uint campaignId, address creator, uint goalAmount, uint deadline);
    event ContributionMade(uint campaignId, address contributor, uint amount);
    event CampaignFinalized(uint campaignId, bool success);
    event FundsWithdrawn(uint campaignId, address contributor, uint amount);

    modifier onlyCreator(uint campaignId) {
        require(msg.sender == campaigns[campaignId].creator, "Not the campaign creator");
        _;
    }

    modifier activeCampaign(uint campaignId) {
        require(block.timestamp < campaigns[campaignId].deadline, "Campaign deadline has passed");
        require(!campaigns[campaignId].isFinalized, "Campaign already finalized");
        _;
    }

    // Create a new crowdfunding campaign
    function createCampaign(uint _goalAmount, uint _durationInDays) external {
        require(_goalAmount > 0, "Goal amount must be greater than 0");
        require(_durationInDays > 0, "Duration should be at least 1 day");

        campaignCount++;
        campaigns[campaignCount].creator = payable(msg.sender);
        campaigns[campaignCount].goalAmount = _goalAmount;
        campaigns[campaignCount].deadline = block.timestamp + (_durationInDays * 1 days);
        campaigns[campaignCount].isFinalized = false;

        emit CampaignCreated(campaignCount, msg.sender, _goalAmount, campaigns[campaignCount].deadline);
    }

    // Contribute to a campaign
    function contribute(uint campaignId) external payable activeCampaign(campaignId) {
        require(msg.value > 0, "Contribution must be greater than 0");

        Campaign storage campaign = campaigns[campaignId];
        campaign.contributions[msg.sender] += msg.value;
        campaign.totalContributed += msg.value;

        emit ContributionMade(campaignId, msg.sender, msg.value);
    }

    // Finalize the campaign: if the goal is met, send funds to creator; else, allow withdrawals
    function finalizeCampaign(uint campaignId) external onlyCreator(campaignId) {
        Campaign storage campaign = campaigns[campaignId];
        require(block.timestamp >= campaign.deadline, "Campaign deadline has not passed");
        require(!campaign.isFinalized, "Campaign already finalized");

        campaign.isFinalized = true;

        if (campaign.totalContributed >= campaign.goalAmount) {
            // Send all funds to the creator
            campaign.creator.transfer(campaign.totalContributed);
            emit CampaignFinalized(campaignId, true);
        } else {
            emit CampaignFinalized(campaignId, false);
        }
    }

    // Withdraw funds if the campaign failed
    function withdraw(uint campaignId) external {
        Campaign storage campaign = campaigns[campaignId];
        require(campaign.isFinalized, "Campaign is not finalized");
        require(campaign.totalContributed < campaign.goalAmount, "Goal was met, no withdrawals allowed");

        uint contributedAmount = campaign.contributions[msg.sender];
        require(contributedAmount > 0, "No funds to withdraw");

        campaign.contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributedAmount);

        emit FundsWithdrawn(campaignId, msg.sender, contributedAmount);
    }
}

