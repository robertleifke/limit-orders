// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract TakeProfitsHook {
    uint256 public number;

    function afterSwap(uint256 newNumber) public {
        sqrtPriceLimitX96

        // convert a number from Q notation to real:
        // divide a constant k by 2**k 

        number = newNumber;
    }

    function beforeSwap() public {
        number++;
    }

    // A limit order is when afterSwap() is higher than beforeSwap() so that the price can be set at a fixed rate
}
