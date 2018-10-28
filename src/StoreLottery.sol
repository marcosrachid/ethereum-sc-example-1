pragma solidity ^0.4.0;

contract StoreLottery {

    address owner;
    bool ownerWeath = false;
    uint luckyNumber;
    uint lotteryCounter = 0;

    constructor(uint startNumber) public {
        require(msg.sender.balance > 99.999999999999 ether);

        luckyNumber = startNumber;
        owner = msg.sender;
        lotteryCounter = 1;
        if (msg.sender.balance > 20 ether) {
            ownerWeath = true;
        } else {
            ownerWeath = false;
        }
    }

    function set(uint sent) public {
        luckyNumber = sent;
        lotteryCounter++;
    }

    function get() public view returns (uint) {
        return luckyNumber;
    }

    function getCounter() public view returns (uint) {
        return lotteryCounter;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getWealth() public view returns (bool) {
        return ownerWeath;
    }
}
