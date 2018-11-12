pragma solidity ^0.4.0;

import {StringUtils} from "libraries/StringUtils.sol";

contract StoreLottery {

    struct ContractConstants {
      address owner;
      string name;
      uint start;
    }

    struct Lottery {
      uint date;
      uint8 luckyNumber;
      address sender;
      uint countShooters;
    }

    ContractConstants constants;

    Lottery[] lotteries;

    mapping(address => uint8) shots;
    address[] shooters;
    address[] winners;

    modifier isOwner() {
      require(msg.sender == constants.owner, "It's required to be the contract owner to perform this execution.");
      _; // continue to run remaing function code
    }

    modifier isNotOwner() {
      require(msg.sender != constants.owner, "Contract owner cannot perform this execution.");
      _; // continue to run remaing function code
    }

    modifier minimunCost(uint min) {
      require(msg.value >= min, string(abi.encodePacked("Needs at least ", StringUtils.uint2str(min), " wei price.")));
      _; // continue to run remaing function code
    }

    modifier lowLuckyNumber(uint _luckyNumber) {
      require(_luckyNumber > 0 && _luckyNumber <= 4 && _luckyNumber == uint8(_luckyNumber), "Lucky number must be between 1 and 4.");
      _; // continue to run remaing function code
    }

    /**
      * deploy contructor
      *
      **/
    constructor(string _name) public {
      constants = ContractConstants({
        owner: msg.sender,
        name: _name,
        start: now
      });
    }

    event ChangeEvent(address payer, uint change);
    event ShotRegistered(address sender, uint8 shot);
    /**
      * register a shot from sender if it doesn't exist
      *
      **/
    function sendShot(uint _luckyNumber) public payable isNotOwner() minimunCost(1000) lowLuckyNumber(_luckyNumber) {
      require (shots[msg.sender] == 0, "Only one shot per lottery.");

      uint change = msg.value - 1000;
      if (change > 0) {
        msg.sender.transfer(change);
        emit ChangeEvent(msg.sender, change);
      }

      shots[msg.sender] = uint8(_luckyNumber);
      shooters.push(msg.sender);
      emit ShotRegistered(msg.sender, shots[msg.sender]);
    }

    /**
      * Show the sender shot if exists
      *
      **/
    function checkShot() public view returns(uint8 luckyNumber) {
      require(shots[msg.sender] > 0, "You don't have a shot for this lottery.");

      return shots[msg.sender];
    }

    /**
      * Return the number of shots/shooters for current lottery
      *
      **/
    function countShots() view public returns(uint count) {
      return shooters.length;
    }

    event LotteryPosted(uint8 result);
    event PrizesSent(uint totalPrize, uint individualPrize);
    /**
      * Lottery to find randomly a number and define the lottery winners and finally delete
      * shots and shooters from arrays to initiate a new lottery
      *
      **/
    function startLottery() public isOwner() returns(uint8 _luckyNumber) {
      require(now > constants.start + 1 minutes, "Lottery can only start after 1 minute of its deploy.");
      require(shooters.length >= 1, "At least 1 person is necessary to start a lottery");

      uint8 luckyNumber = uint8(keccak256(abi.encodePacked(blockhash(block.number-1))))/64+1;
      emit LotteryPosted(luckyNumber);

      lotteries.push(Lottery({
        date: now,
        luckyNumber: luckyNumber,
        sender: msg.sender,
        countShooters: shooters.length
      }));

      for (uint i = 0;i < shooters.length; i++) {
        address shooter = shooters[i];
        if (shots[shooter] == luckyNumber) {
          winners.push(shooter);
        }
        delete shots[shooter];
      }

      uint totalPrize = address(this).balance;
      if (winners.length > 0) {
        uint prize = totalPrize / winners.length;

        for (i = 0; i < winners.length; i++) {
          winners[i].transfer(prize);
        }
        emit PrizesSent(totalPrize, prize);
      }

      delete shooters;
      delete winners;

      return luckyNumber;
    }

    /**
      * Contract destruction
      *
      **/
    function kill() public isOwner() {
        constants.owner.transfer(address(this).balance);
        selfdestruct(constants.owner);
    }
}
