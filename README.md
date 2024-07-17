# Explanation:

## Variables:
- manager: Address of the manager who deploys the contract.
- players: Array holding the addresses of all participants who have bought tickets.
- winner: Address of the winner of the lottery draw.
- ticketPrice: Price per lottery ticket in wei.
- minimumPlayers: Minimum number of players required to conduct a draw.
- randomSeed: Seed used for generating random numbers.

## Constructor:
Sets the manager as the contract creator (the address that deploys the contract).

## Functions:
- buyTicket(): Allows users to buy a ticket by sending the correct amount of ether (ticketPrice). Adds the sender's address to the players array.

- conductDraw(): Conducts the draw to determine the winner. It requires that there are enough players (minimumPlayers). Uses a simple random number generation method (keccak256 hash of block information and randomSeed) to select a winner and transfers the contract balance to the winner.

- resetLottery(): Resets the lottery for the next round by clearing the players array and updating the randomSeed.

## Modifiers:

- restricted(): Restricts access to functions that should only be called by the manager.

## View Functions:

- getPlayers(): Retrieves the array of addresses of current players.
- getContractBalance(): Retrieves the current balance (in wei) of the contract.

## Usage:

- Deploy the contract using an Ethereum development environment like Remix or Truffle, or you can deploy using Vottun APIs and and interact with it using the Vottun APIs.

- Players can interact with the contract by calling buyTicket() to purchase tickets.
    
- The manager calls conductDraw() once enough players have purchased tickets.

- After the draw, players can check if they won by examining the winner variable.

- The manager can withdraw the contract balance using regular Ethereum wallet operations.
