// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.14;

contract Piggy {

  struct Donation {
      address from;
      uint amount;
  }

  mapping(address => Donation[]) public Piggies;

  receive () external payable {}

  function createPiggy(address _owner) public {
    require(
      Piggies[_owner].length <= 0,
      "This piggy exists."
    );
    _addInPiggy(_owner, msg.sender, 0);
  }

  function donate (address _to) public payable {
    require(
      Piggies[_to].length > 0,
      "This piggy exists."
    );
    require(
      msg.value > 0,
      "amount need to be more than 0."
    );

    _addInPiggy(_to, msg.sender, msg.value);
    payable(this).transfer(msg.value);
  }

  function _addInPiggy (address _to, address _from, uint _amount) private {
    require(
      _from != _to,
      "You cant found yourself"
    );

    Donation memory donation = Donation({
      from: _from,
      amount: _amount
    });
    Piggies[_to].push(donation);
  }

  function getPiggy (address _of) public view returns(Donation[] memory) {
    require(
      Piggies[_of].length >= 0,
      "This piggy don't exists"
    );
    return Piggies[_of];
  }

  function getBalance () public view returns(uint) {
    return address(this).balance;
  }

  function _getTotal (address _owner) public view returns(uint) {
    uint total = 0;
    for (uint i = 0; i < Piggies[_owner].length; i++) {
      total += Piggies[_owner][i].amount;
    }
    return total;
  }

  function withdraw () public payable {
    uint total = _getTotal(msg.sender);
    require(total > 0, "You dont have an amount");
    payable(msg.sender).transfer(_getTotal(msg.sender));
    delete Piggies[msg.sender];
  }

}
