// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdfundingImproved {
    uint256 goal;
    uint256 currentAmount;
    bool completed;
    string name;
    string description;
    string lastStatusLog;
    address payable ownerWallet;

    constructor (uint256 _goal, string memory _name, string memory _description, address payable _ownerWallet) public payable {
        goal = _goal;
        completed = false;
        name = _name;
        description = _description;
        ownerWallet = _ownerWallet;
        lastStatusLog = "Looking for investors";
    }

    function foundProject() public payable {
        if(!completed) {
            ownerWallet.transfer(msg.value);
            currentAmount += msg.value;
            changeProjectState();
        } else {
            lastStatusLog = "This project has been fully founded.";
        }
    }

    function getStatus() public view returns(string memory) {
        return lastStatusLog;
    }

    function changeProjectState() private {
        if(currentAmount >= goal) {
            completed = true;
            lastStatusLog = "Congrats! This project has been fully founded.";
        } else {
            lastStatusLog = "Thanks for your investment.";
        }
    }
}