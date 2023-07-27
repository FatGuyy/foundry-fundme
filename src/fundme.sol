
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {price} from "./getprice.sol";


error notOwner();

contract Fundme{
    uint256 public minimumUSD = 5 * 1e18;
    address public immutable OWNER;
    address[] public funders;
    mapping(address => uint256) public addressToFunder;

    constructor(){
        OWNER = msg.sender;
    }

    // Function to get money in
    function fund() public payable {
        require(price.getConversionRate(msg.value) >= minimumUSD, "Less than mimimum amount.");
        funders.push(msg.sender);
        addressToFunder[msg.sender] += msg.value;
    }

    function getVersion() public  view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function withdraw() public onlyOwner {
        // Making the funders array to zero again
        for (uint256 index = 0; index < funders.length; index++){
            addressToFunder[funders[index]] = 0;
        }
        funders = new address[](0);
        
        //Transfering the money part
        (bool success,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Failed to transfer");
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    modifier onlyOwner{
        if (msg.sender != OWNER){
            revert notOwner();
        }
        _;
    }
    }