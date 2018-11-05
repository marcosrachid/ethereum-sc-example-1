pragma solidity ^0.4.0;

contract StoreLottery {

    address owner;
    uint lotteryCounter = 0;

    uint8 luckyNumber = 0;
    uint8[] luckyNumbers;

    modifier isOwner() {
      require(msg.sender == owner, "It's required to be the contract owner to perform this execution.");
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

    constructor(uint256 _luckyNumber) public payable lowLuckyNumber(_luckyNumber) lowBalance() {
        owner = msg.sender;
        set(_luckyNumber);
    }

    function set(uint256 _luckyNumber) public payable isOwner() minimunCost(1000) lowLuckyNumber(_luckyNumber) {
        luckyNumber = uint8(_luckyNumber);
        luckyNumbers.push(luckyNumber);
        lotteryCounter++;

        if (msg.value > 1000) {
          uint change = msg.value - 1000;
          msg.sender.transfer(change);
          emit changeEvent(msg.sender, change);
        }
    }

    function get() public view returns (address _owner, uint8 _luckyNumber, uint _lotteryCounter, uint balance, uint8[] _luckyNumbers) {
        return (owner,
                luckyNumber,
                lotteryCounter,
                address(this).balance,
                luckyNumbers
                );
    }

    function getLuckyNumber() public view returns (uint8) {
        return luckyNumber;
    }

    function getCounter() public view returns (uint) {
        return lotteryCounter;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function kill() public isOwner() {
        selfdestruct(owner);
    }
}
