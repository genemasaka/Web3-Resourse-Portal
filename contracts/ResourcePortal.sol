//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.4;

import "hardhat/console.sol";

contract ResourcePortal {
    uint256 totalResources;

    uint256 private seed;

    event NewResource(address indexed from, uint256 timestamp, string message);

    struct Resource {
        address sender;
        string message;
        uint256 timestamp;
    }

    Resource[] resources;

    mapping(address => uint256) public lastResourceShared;

    constructor() payable {
        console.log("I am a badass web3 dev");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function resource(string memory _message) public{

        require(
            lastResourceShared[msg.sender] + 1 minutes < block.timestamp,
            "Wait 15m"
        );

        lastResourceShared[msg.sender] = block.timestamp; 

        totalResources += 1;
        console.log("%s has added a resource!", msg.sender);

        resources.push(Resource(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);  

            uint256 reward = 0.0001 ether;

            (bool success, ) = (msg.sender).call{value: reward}("");

             require(success, "Failed to withdraw money from contract"); 
        }

        // require (
        //     reward <= address(this).balance,
        // );
        emit NewResource(msg.sender, block.timestamp, _message);
    }
    
    function getAllResources() public view returns (Resource[] memory) {
        return resources;
    }

    function getTotalResources() public view returns (uint256) {
        console.log("We have %d total resources!", totalResources);
        return(totalResources);
    }
    
}