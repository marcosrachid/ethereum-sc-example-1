pragma solidity ^0.4.0;

contract StoreLottery {

    address owner;

    struct Lottery {
      uint date;
      uint8 luckyNumber;
      address sender;
    }

    Lottery[] lotteries;

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
        lotteries.push(Lottery({
          date: now,
          luckyNumber: uint8(_luckyNumber),
          sender: msg.sender
        }));

        if (msg.value > 1000) {
          uint change = msg.value - 1000;
          msg.sender.transfer(change);
          emit changeEvent(msg.sender, change);
        }
    }

    function get() public view returns (address _owner, uint _balance, uint _lastDate, uint8 _lastLuckyNumber, address _lastSender) {
        return (
                owner,
                address(this).balance,
                lotteries[lotteries.length - 1].date,
                lotteries[lotteries.length - 1].luckyNumber,
                lotteries[lotteries.length - 1].sender
        );
    }

    function getLastLuckyNumber() public view returns (uint8) {
        return lotteries[lotteries.length - 1].luckyNumber;
    }

    function getCounter() public view returns (uint) {
        return lotteries.length;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function kill() public isOwner() {
        selfdestruct(owner);
    }
}
