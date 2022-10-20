// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Number {
    //Public function
    function getNumber() public returns (int number) {
        number = 1948;
    }

    function changeNumber() public returns (int number) {
        number = getNumber() * -1;
    }

    //Private function
    function getNumberPrivate() private returns (int number) {
        number = 1948;
    }

    function changeNumberPrivate() public returns (int number) {
        number = getNumber() * -1;
    }

    //Payable function
    function sendEther(address payable receiver) public payable {
        receiver.transfer(msg.value);
    }
    //View function
    string name = "Nicolas";
    function getName() public view returns (string memory) {
        return name;
    }
    
    //pure function 
    function sum(int a, int b) public pure returns(int result) {
        result = a + b;
    }
}