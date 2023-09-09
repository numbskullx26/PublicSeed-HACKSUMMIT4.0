// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract PublicSeed {

    // all the different attributes of the structure campaign
    struct Campaign{
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0; //gobal variable to keep track of all the campaigns


    // different functionalities/operations

    function createCampaign(address _owner,string memory _title,string memory _description,uint256 _target,uint256 _deadline,string memory _image) public returns (uint256) {
        
        Campaign storage campaign = campaigns[numberOfCampaigns];
        
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future.");

        //the below code will be executed only if the require condition is satisfied.

        campaign.owner = _owner;
        campaign.title=_title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;
        //returning the index of the latest stored campaign number.
        return numberOfCampaigns - 1;

    }


    function donateToCampaign(uint256 _id) public payable {
        //payable : specifies that this function will be used for transaction
        uint256 amount = msg.value;
        Campaign storage campaign = campaigns[_id];
        
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);
        //sending the "amount" to the owner 
        (bool sent, ) = payable(campaign.owner).call{value : amount}("");

        if(sent){
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    } 

    function getDonators(uint256 _id) view public returns(address[] memory,uint256[] memory){
        return(campaigns[_id].donators , campaigns[_id].donations);
    }

    function getCampaigns() public view returns(Campaign[] memory){
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        for( uint i = 0;i<numberOfCampaigns;i++){
            Campaign storage item = campaigns[i];
            
            allCampaigns[i] = item;
        }

        return allCampaigns;
    }

}