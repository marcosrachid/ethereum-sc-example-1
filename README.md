# ethereum-sc-example-1
Practical ethereum smart contract example

## Function Structure

```
function (<parameter types>) {(visibility) internal|external}
[pure|constant|view|payable][returns (<return types>)]
```

## Types

* bool: can be "true" or "false";
* int or int256: is an integer 256 bits signed;
* int8 to int256: from 8 to 8, is a signed integer with the referenced number of bits;
* uint or uint256: is an integer 256 bits unsigned;
* uint8 to uint256: from 8 to 8, is a unsigned integer with the referenced number of bits;
* address: 20 bytes of information referenced to an ethereum account (like an object);
  * balance: get account current balance;
  * transfer: account receives an amount;
  * call:  is a low-level interface for sending a message to a contract. It returns false if the subcall encounters an exception, otherwise it returns true(use not recommended);
* string: text variable set between double quotes.

## Ether Units

* wei: 1 == 1 wei;
* szabo(miliether): 1 == 1,000,000,000,000(1e12) wei;
* finney(microether): 1 == 1,000,000,000,000,000(1e15) wei;
* ether: 1 == 1,000,000,000,000,000,000(1e18) wei.

## Time Units

* seconds: 1 == 1 seconds;
* minutes: 1 == 60 seconds;
* hours: 1 == 60 minutes;
* days: 1 == 24 hours;
* weeks: 1 == 7 days;
* years: 1 == 365 days
  * BEWARE: leap years.

## Platform Properties

* block.blockhash(uint blockNumber) returns (bytes32): hash from a block;
* block.number(uint): actual block number;
* block.timestamp(uint) or now(uint): actual block timestamp(in seconds);
* gasleft() returns (uint256): lefting gas;
* msg.sender(address): account address that called the contract;
* msg.value(uint): amount of wei sent with the message.

Source  | Data
------------- | -------------
Link  | <https://solidity.readthedocs.io/en/v0.4.25/units-and-global-variables.html#special-variables-and-functions>

## Visibility

* public/external
* private/internal

## Modifiers

* constant/view: Use the global variable and access within the function only. Scope only within the function;
* pure: Only access local variable do not access the global variable;
* payable: Modify the global variable (or) rewritte the global variable. Scope outside function used.
