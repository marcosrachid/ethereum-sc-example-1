pragma solidity ^0.4.0;

contract StoreLottery {

    address owner;
    bool ownerWeath = false;
    uint8 luckyNumber;
    uint lotteryCounter = 0;

    modifier isOwner() {
      require(msg.sender == owner, "It''s required to be the contract owner to perform this execution.");
      _; // continue to run remaing function code
    }

    modifier minimunCost(uint min) {
      require(msg.value >= min, "Insuficient Ether.");
      _; // continue to run remaing function code
    }

    modifier lowLuckyNumber(uint _luckyNumber) {
      require(_luckyNumber == uint8(_luckyNumber), "Lucky number does not fit on global type uint8.");
      _; // continue to run remaing function code
    }

    modifier lowBalance() {
      require(msg.sender.balance > 99 ether, "Deployer does not have more then 99 ether.");
      _; // continue to run remaing function code
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

    function set(uint256 _luckyNumber) public payable isOwner() minimunCost(1000) lowLuckyNumber(_luckyNumber) {
        luckyNumber = uint8(_luckyNumber);
        lotteryCounter++;

        if (msg.value > 1000) {
          uint change = msg.value - 1000;
          msg.sender.transfer(change);
          emit changeEvent(msg.sender, change);
        }
    }

    function get() public view returns (uint8 _luckyNumber, uint _lotteryCounter, address _contract, uint balance) {
        return (luckyNumber,
                lotteryCounter,
                this,
                address(this).balance);
    }

    function getLuckyNumber() public view returns (uint8) {
        return luckyNumber;
    }

    function getCounter() public view returns (uint) {
        return lotteryCounter;
    }

    function getOwner() public view isOwner() returns (address) {
        return owner;
    }

    function getWealth() public view isOwner() returns (bool) {
        return ownerWeath;
    }
}
