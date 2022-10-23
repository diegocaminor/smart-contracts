// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdfundingPlatzi {
    struct Project {
        string id;
        string name;
        string description;
        address payable author;
        uint state;
        uint funds;
        uint fundraisingGoal;
    }

    Project public project;

    event ProjectFunded(
        string projectId,
        uint value
    );

    event ProjectStateChanged (
        string projectId,
        uint state
    );



    constructor (string memory _id, string memory _name, string memory _description, uint _fundraisingGoal) {
        project = Project(_id, _name, _description, payable(msg.sender), 1, 0, _fundraisingGoal);
    }



    modifier isNotAuthor() {
        require(msg.sender != project.author, "As author you can not fund your own project");
        _;
    }

    modifier isAuthor() {
        require(msg.sender == project.author, "You need to be the project owner");
        _;
    }

    error stateNotDefined(uint state);

    function foundProject() public payable isNotAuthor {
        require(msg.value > 0, "Fund value must be greater than 0");
        require(project.state == 1, "The crowdfunding is closed, you can not contribute anymore to the project");
        project.author.transfer(msg.value);
        project.funds += msg.value;
        emit ProjectFunded(project.id, msg.value);
    }

    function changeProjectState(uint newState) public isAuthor {
        require(project.state != newState, "New state must be different");
        project.state = newState;
        emit ProjectStateChanged(project.id, newState);
    }
}