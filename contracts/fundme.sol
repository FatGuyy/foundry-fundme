//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Fundme{
    uint256 public minimumUSD = 5;

    function fund() public payable {
        require(msg.value >= minimumUSD, "Not enough money");
    }

}