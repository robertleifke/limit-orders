# Uniswap V4 Hook Example

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

Ticks repersent prices for a given pair in Uniswap v4 as they do in V3. Becuase solidity does support floating point arithemtic (decimals), Uniswap uses `Q` notation. In short, we can repersent decimals as fixed point artithemtic (integers) by converting it. 

Convert `sqrtPriceX96` to `sqrtPrice` by dividing $2^{96}$. Read more here:

https://blog.uniswap.org/uniswap-v3-math-primer

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
