pragma solidity ^0.4.0;

contract StoreLottery {

    address owner;
    bool ownerWeath = false;
    uint8 luckyNumber;
    uint lotteryCounter = 0;

    modifier minimunCost(uint min) {
      require(msg.value >= min, "Insuficient Ether.");
      _; // continue to run remaing function code
    }

    modifier lowLuckyNumber(uint _luckyNumber) {
      require(_luckyNumber == uint8(_luckyNumber), "lucky number does not fit on global type uint8.");
      _;
    }

    modifier lowBalance() {
      require(msg.sender.balance > 99 ether, "deployer does not have more then 99 ether.");
      _;
    }

    event changeEvent(address payer, uint change);

    constructor(uint256 _luckyNumber) public lowLuckyNumber(_luckyNumber) lowBalance() {
        luckyNumber = uint8(_luckyNumber);
        owner = msg.sender;
        lotteryCounter = 1;
        if (msg.sender.balance > 20 ether) {
            ownerWeath = true;
        } else {
            ownerWeath = false;
        }
    }

    function set(uint256 _luckyNumber) public payable minimunCost(1000) lowLuckyNumber(_luckyNumber) {
        luckyNumber = uint8(_luckyNumber);
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
