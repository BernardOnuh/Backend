// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Why is this a library and not abstract?
// Why not an interface?
library PriceConverter {
    // We could make this public, but then we'd have to deploy it
    function getPrice() internal view returns (uint256) {
        // MumbaiMatic MATIC / USD Address
        // https://docs.chain.link/docs/polygon-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // Matic/USD rate in 18 digit
        return uint256(answer * 10000000000);
        // or (Both will do the same thing)
        // return uint256(answer * 1e10); // 1* 10 ** 10 == 10000000000
    }

    // 1000000000
    function getConversionRate(uint256 maticAmount)
        internal
        view
        returns (uint256)
    {
        uint256 maticPrice = getPrice();
        uint256 maticAmountInUsd = (maticPrice * maticAmount) / 1000000000000000000;
        // or (Both will do the same thing)
        // uint256 maticAmountInUsd = (ethPrice * ethAmount) / 1e18; // 1 * 10 ** 18 == 1000000000000000000
        // the actual MATIC/USD conversion rate, after adjusting the extra 0s.
        return maticAmountInUsd;
    }
}
