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
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0; //gobal variable to keep track of all the campaigns


    // different functionalities/operations

    function createCampaign(address _owner,string memory _title,string memory _description,uint256 _target,uint256 _deadline,string memory _image) public returns (uint256) {}
    

    function donateToCampaign() {}

    function getDonators() {}

    function getCampaigns() {}

}