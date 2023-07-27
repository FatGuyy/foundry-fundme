// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library price {

    function getprice() public   view  returns (uint256) {
        AggregatorV3Interface priceFeed =   AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer ,,,) = priceFeed.latestRoundData();

        return uint256(answer * 10000000000);
    }

    // 1000000000
    function getConversionRate(uint256 ethamount) public view returns (uint256){
        uint256 ethPrice = getprice();
        uint256 ethInUSD = (ethPrice * ethamount)/100000000000000000;
        return ethInUSD;
    } 
}