// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";



contract FundMe {
    using PriceConverter for uint256;
    uint256 public amount;
    mapping (address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    uint256 public constant MINIMUM_USD = 1 * 10 ** 18;

    constructor() {
        owner = msg.sender;
    }

function Amount(uint256 _amount) external virtual {
    amount = _amount;
}

function retrieve() external view returns (uint256){
    return amount;
}

function fund() public payable {
    require(msg.value.getConversionRate() >= MINIMUM_USD, "You can't send less than 1$ ");
    //require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD,
    addressToAmountFunded[msg.sender] += msg.value;
    funders.push(msg.sender);
}
function getVersion() public view  returns (uint256) {
    //MATIC/USD price feed address of Mumbai Network.abi
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada);
    return priceFeed.version();
}

modifier onlyOwner {
    require(msg.sender == owner, 'Sender is not owner!'); 
    _;
}
function withdraw() public onlyOwner {
    for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
    }
    funders = new address[](0);

    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call failed");
}
  fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

}
