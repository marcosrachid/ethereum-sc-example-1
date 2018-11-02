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
  * call:  is a low-level interface for sending a message to a contract. It returns false if the subcall encounters an exception, otherwise it returns true(use not recommended).


## Visibility

* public/external
* private/internal

## Modifiers

* constant/view: Use the global variable and access within the function only. Scope only within the function;
* pure: Only access local variable do not access the global variable;
* payable: Modify the global variable (or) rewritte the global variable. Scope outside function used.
