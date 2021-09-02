pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Portal {
    uint totalWaves;
    uint private seed;

    struct Wave {
        address waver; //address of user
        uint timestamp; // timestamp of wave
        string message; // message user sent
    }

   // array to hold stucts, basically all the data
    Wave[] waves;

    event NewWave(address indexed from, uint timestamp, string message);

    mapping(address => uint) public lastWavedAt;

    constructor() payable {
        console.log("You have been constructed");
    }

    function wave(string memory _message) public {
        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "must wait for 30 sec");

        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves += 1;
        console.log('%s is waved with message %s', msg.sender, _message);
        waves.push(Wave(msg.sender, block.timestamp, _message));

        uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: ", randomNumber);

        seed = randomNumber;

        if(randomNumber < 50){
        console.log("%s won!", msg.sender);

        uint prizeAmount = 0.0001 ether;
        require(prizeAmount <= address(this).balance, "Trying to withdraw more money than contract has");
        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() view public returns(Wave[] memory){
        return waves;
    }

    function getTotalWaves() view public returns(uint) {     
        return totalWaves;
    }
}