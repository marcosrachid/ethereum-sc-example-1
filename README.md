# ethereum-sc-example-1
Practical ethereum smart contract example

## Function Structure

```
function (<parameter types>) {(visibility) internal|external}[pure|constant|view|payable][returns (<return types>)]
```

## Visibility

* public
* external
* internal
* private

## Modifiers

* pure: can't change state;
* view: can't change state;
* payable: can receive ether;
* constant: can't store info.
