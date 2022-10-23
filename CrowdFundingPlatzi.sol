// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdfundingPlatzi {
    string public id;
    string public name;
    string public description;
    address payable public author;
    uint public state = 1;
    uint public funds;
    uint public fundraisingGoal;

    constructor (string memory _id, string memory _name, string memory _description, uint _fundraisingGoal) {
        id = _id;
        name = _name;
        description = _description;
        fundraisingGoal = _fundraisingGoal;
        author = payable(msg.sender);
    }

    event ProjectFunded(
        string projectId,
        uint value
    );

    event ProjectStateChanged (
        string projectId,
        uint state
    );

    modifier isNotAuthor() {
        require(msg.sender != author, "As author you can not fund your own project");
        _;
    }

    modifier isAuthor() {
        require(msg.sender == author, "You need to be the project owner");
        _;
    }

    error stateNotDefined(uint state);

    function foundProject() public payable isNotAuthor {
        require(msg.value > 0, "Fund value must be greater than 0");
        require(state == 1, "The crowdfunding is closed, you can not contribute anymore to the project");
        author.transfer(msg.value);
        funds += msg.value;
        emit ProjectFunded(id, msg.value);
    }

    function changeProjectState(uint newState) public isAuthor {
        require(state != newState, "New state must be different");
        state = newState;
        emit ProjectStateChanged(id, newState);
    }
}