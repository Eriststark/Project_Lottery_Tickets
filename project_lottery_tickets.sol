// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address public manager; // Manager address who creates the lottery
    address[] public players; // Addresses of participants
    address public winner; // Address of the winner
    uint public ticketPrice = 1 ether; // Price per lottery ticket in wei
    uint public minimumPlayers = 2; // Minimum number of players to conduct a draw
    uint public randomSeed; // Random seed for generating winner

    constructor() {
        manager = msg.sender; // Assign manager as the contract creator
    }

    // Function to allow players to buy tickets
    function buyTicket() public payable {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        players.push(msg.sender); // Add player to the players array
    }

    // Function to conduct the draw and determine the winner
    function conductDraw() public restricted {
        require(players.length >= minimumPlayers, "Not enough players");
        
        // Generate random winner using block hash and current time
        bytes32 rand = keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp, randomSeed));
        uint index = uint(rand) % players.length;
        winner = players[index]; // Select winner

        // Transfer balance to the winner
        payable(winner).transfer(address(this).balance);
        
        // Reset lottery for the next round
        resetLottery();
    }

    // Function to reset lottery after draw
    function resetLottery() private {
        delete players; // Clear players array
        randomSeed = randomSeed + 1; // Update random seed for next draw
    }

    // Modifier to restrict access to certain functions to the manager only
    modifier restricted() {
        require(msg.sender == manager, "Restricted to manager");
        _;
    }

    // Function to get current players
    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    // Function to get contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}

