pragma solidity ^0.4.0;

contract StoreLottery {

    address owner;
    bool ownerWeath = false;
    uint luckyNumber;
    uint lotteryCounter = 0;

    constructor(uint startNumber) public {
        require(msg.sender.balance > 99.999999 ether);

        luckyNumber = startNumber;
        owner = msg.sender;
        lotteryCounter = 1;
        if (msg.sender.balance > 20 ether) {
            ownerWeath = true;
        } else {
            ownerWeath = false;
        }
    }

    modifier minimunCost(uint min) {
      require(msg.value >= min, "Insuficient Ether.");
      _; // continue to run remaing function code
    }

    event changeEvent(address payer, uint change);

    function set(uint sent) public payable minimunCost(1000) {
        luckyNumber = sent;
        lotteryCounter++;

        if (msg.value > 1000) {
          uint change = msg.value - 1000;
          msg.sender.transfer(change);
          emit changeEvent(msg.sender, change);
        }
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
