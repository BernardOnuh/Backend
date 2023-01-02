// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Fundme.sol";

contract NewFundme {
    address [] public Funders;
    event newFundersAddress(address _FundersAdress);

    function CreateNewFundme() public {

        FundMe fundme = new FundMe();
        address  FundersAddress = address(fundme);
        emit newFundersAddress(FundersAddress);
        Funders.push(FundersAddress);
    }
    function retrieve() external view returns (address){
        return address;
    }
}
