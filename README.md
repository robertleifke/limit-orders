# Limit Order Hook on Uniswap V4

Custom hook logic for placing a **limit order** on any Uniswap v4 *concentrated liquidity* pool.

Exampled based on https://learnweb3.io/lessons/uniswap-v4-hooks-create-a-fully-on-chain-take-profit-orders-hook-on-uniswap-v4/

## Limit Orders

Allows users to place and cancel a limit (take-for-profit) order fully on-chain by:

1. Users places limit order by calling `placeOrder()` in the v4 hook.
2. User mints ERC-1155 token as receipt of limit order. Allows user to withdraw funds if order is fufilled. 
3. `afterswap()` function is used to check the new price everytime the user makes a swap. So if market price is greater than the "strike" price or price set on a tick, $p > s$ the order is in profit and therefore fufilled (market selling).
4. Users burn ERC-1155 recipt token to withdraw fufilled tokens. 

`TakeProfitsHook` contract is `BaseHook` and a `ERC1155` token.

BaseHook is a template contract provided by Uniswap Labs that implements `IHook` interface. 

V4 hooks use the `poolManager` as a controller and in order to override a function that the hook is selecting it must return a function selector so that the `poolManger` can verify that the custom hook is calling the correct function.

Ticks repersent prices for a given pair in Uniswap v4 as they do in V3. Becuase solidity does support floating point arithemtic (decimals), Uniswap uses `Q` notation. In short, we can repersent decimals as fixed point artithemtic (integers) by converting it. 

Convert `sqrtPriceX96` to `sqrtPrice` by dividing $2^{96}$. Read more here:

https://blog.uniswap.org/uniswap-v3-math-primer

To figure out the **price at a tick** we use the formula: $p(i) = 1.001^{i}$. 

Since all prices are denominated in a "quote" token from a pair we have `tokenA` and `tokenB` where if the tick is `90` then the price of `tokenA` at that tick is $p(90) = 1.001^{90}$ which is equal to $1.09412507977$ and therefore 1 `tokenA` = 1.09412507977 `tokenB`. 

So if we take the case of ETH in a ETH/USD pair, to get the exchange rate at a tick we simply use the formula where at tick $i = 1060$:

....

Do to the `.001` or 1 bip interval Uniswap have a `tickLower` and `tickUpper` to avoid rounding issues. 

In order to manipulate the ticks we need to store them with each pool using a mapping data structure which has a key and value. The key is the `PoolKey` and the value is `PoolID`, a `bytes32` type inherited from the `PoolIDLibrary`.

When a pool is intialized so is a tick with an arbitary value. Calling `afterInitialize` we can pass in a tick value and it calculates the new `tickLower` value.

A limit order is placed for a specific `PoolID` at a specific `tick` in a specific direction, `zeroForOne` (sell)., and for a specofoc `amount` of tokens.

## TO-DOs

- [ ] Write forge tests
- [ ] Implement `afterSwap()`

## Local Deployment and Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
