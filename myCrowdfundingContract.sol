// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyCrowdfundingContract {
    uint public goal;
    uint public currentFund;
    bool public isComplete;
    address public donorWallet;
    address payable public ownerWallet;

    constructor(address payable _ownerWallet) {
        donorWallet = msg.sender;
        goal = 1000;
        currentFund = 0;
        isComplete = false;
        ownerWallet = _ownerWallet;
    }

    function fundProject() public payable returns (string memory text) {
        if (!isComplete) {
            ownerWallet.transfer(msg.value);
            currentFund = currentFund + msg.value;
            if(currentFund >= goal) changeProjectState();
            text = "Thanks for collaborating with us ";
            // text = string.concat(text, donorName, donorWallet); figure out why this not works properly
        } else {
            text = "We already achieve the goal! thanks anyway";
        }
    }

    function changeProjectState() private returns (bool) {    
        isComplete = true;
        return isComplete;
    }
}