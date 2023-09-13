// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
pragma solidity ^0.8.21;

contract limitOrder {
    uint256 public number;
import {BaseHook} from "periphery-next/BaseHook.sol";
import {ERC1155} from "openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import {IPoolManager} from "v4-core/interfaces/IPoolManager.sol";
import {Hooks} from "v4-core/libraries/Hooks.sol";
import {PoolId, PoolIdLibrary} from "v4-core/types/PoolId.sol";
import {PoolKey} from "v4-core/types/PoolKey.sol";

    function afterSwap(uint256 newNumber) public {
        sqrtPriceLimitX96

        // convert a number from Q notation to real:
        // divide a constant k by 2**k 
contract limitOrder is BaseHook, ERC1155 {

        number = newNumber;
    }
    // Initialize BaseHook and ERC1155 parent contracts in the constructor
    constructor(IPoolManager _poolManager, string memory _uri) 
BaseHook(_poolManager) ERC1155(_uri) {}

    function beforeSwap() public {
        number++;
    // Required override function for BaseHook to let the PoolManager know which hooks are implemented
    function getHooksCalls() public pure override returns (Hooks.Calls memory) {
        return Hooks.Calls({
                beforeInitialize: false,
                afterInitialize: true,
                beforeModifyPosition: false,
                afterModifyPosition: false,
                beforeSwap: false,
                afterSwap: true,
                beforeDonate: false,
                afterDonate: false
        });
    }

    // A limit order is when afterSwap() is higher than beforeSwap() so that the price can be set at a fixed rate
}

    // Use the PoolIdLibrary for PoolKey to add the `.toId()` function on a PoolKey
    // which hashes the PoolKey struct into a bytes32 value
    using PoolIdLibrary for IPoolManager.PoolKey;

    // Create a mapping to store the last known tickLower value for a given Pool
    mapping(PoolId poolId => int24 tickLower) public tickLowerLasts;

    // Create a nested mapping to store the sell orders placed by users
    // The mapping is PoolId => tickLower => zeroForOne => amount
    // PoolId => (...) specifies the ID of the pool the order is for
    // tickLower => (...) specifies the tickLower value of the order i.e. sell when price is greater than or equal to this tick
    // zeroForOne => (...) specifies whether the order is swapping Token 0 for Token 1 (true), or vice versa (false)
    // amount specifies the amount of the token being sold
    mapping(PoolId poolId => mapping(int24 tick => mapping(bool zeroForOne => int256 amount))) public SellPositions;

    // Hooks
    function afterInitialize(
        address,
        PoolKey calldata key,
        uint160,
        int24 tick,
        // Add bytes calldata after tick
        bytes calldata
        ) 
        external override poolManagerOnly returns (bytes4) {
            _setTickLowerLast(key.toId(), _getTickLower(tick, key.tickSpacing));
            return limitOrder.afterInitialize.selector;
}