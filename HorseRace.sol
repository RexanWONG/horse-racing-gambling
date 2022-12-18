// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract HorseRace {
    uint public minBet = 1 ether;

    // The total amount of ether bet on each horse
    uint public horse1BetTotal;
    uint public horse2BetTotal;
    uint public horse3BetTotal;
    uint public horse4BetTotal;
    uint public horse5BetTotal;

    // The address of the winner
    address public winner;

    // The event that is emitted when the race is over
    event LogRaceOver(address winner);

    // The function that starts the race
    function startRace() public {
        // Randomly select a winner
        uint rand = random();
        if (rand < 1/5) {
            winner = address(this);
        } else if (rand < 2/5) {
            winner = address(this);
        } else if (rand < 3/5) {
            winner = address(this);
        } else if (rand < 4/5) {
            winner = address(this);
        } else {
            winner = address(this);
        }

        // Emit the event to indicate that the race is over
        emit LogRaceOver(winner);
    }

    // Allows a user to place a bet on a horse
    function bet(uint horseNumber, uint amount) public payable {
        // Check that the bet amount is greater than or equal to the minimum bet amount
        require(amount >= minBet, "Bet amount must be greater than or equal to the minimum bet amount.");

        // Check that the contract has sufficient balance to cover the bet
        require(address(this).balance >= amount, "The contract does not have sufficient balance to cover the bet.");

        // Add the bet amount to the total bet amount for the selected horse
        if (horseNumber == 1) {
            horse1BetTotal += amount;
        } else if (horseNumber == 2) {
            horse2BetTotal += amount;
        } else if (horseNumber == 3) {
            horse3BetTotal += amount;
        } else if (horseNumber == 4) {
            horse4BetTotal += amount;
        } else if (horseNumber == 5) {
            horse5BetTotal += amount;
        }

        // Transfer the bet amount to the contract
        msg.sender.transfer(amount);
    }

    // Allows a user to claim their winnings
    function claimWinnings() public {
        // Check that the race is over
        require(winner != address(0), "The race is not yet over.");

        // Check that the caller is the winner
        require(msg.sender == winner, "Only the winner can claim their winnings.");

        // Calculate the total bet amount
        uint totalBet = horse1BetTotal + horse2BetTotal + horse3BetTotal + horse4BetTotal + horse5BetTotal;

        // Calculate the winnings amount
        uint winnings = totalBet / winner.balance;

        // Transfer the winnings amount to the winner
        winner.transfer(winnings);
    }
}
