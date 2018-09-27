pragma solidity ^0.4.2;


contract EDollarToken {
  string public name = "EDollar";
  string public symbol = "EDollar";
  string public standard = "EDollar v1.0";
  uint256 public totalSupply; // total number of tokens
  mapping (address => uint256) public balanceOf;
  mapping (address => mapping (address => uint256) ) public allowancee;

  event Transfer (
    address indexed _from,
    address indexed _to,
    uint256 _value
    );

    event Approval(
      address indexed _owner,
      address indexed _spender,
      uint256 _value
    );


  constructor (uint256 _initialSupply) public {
    totalSupply = _initialSupply;
    balanceOf[msg.sender] = totalSupply;
  }

  function transfer(address _to, uint256 _value) public returns (bool success){
    require(balanceOf[msg.sender] >= _value);

    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
    return true;

  }


  function approve(address _spender, uint256 _value) public returns (bool success){
    require(  balanceOf[msg.sender] >= (_value + allowancee[msg.sender][_spender])   );
    allowancee[msg.sender][_spender] += _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }


   function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
     require(_value <= balanceOf[_from]);
       require(_value <= allowancee[_from][msg.sender]);

       balanceOf[_from] -= _value;
       balanceOf[_to] += _value;

       allowancee[_from][msg.sender] -= _value;

       emit Transfer(_from, _to, _value);

       return true;
   }

  function allowance(address _owner, address _spender) public view returns (uint256 remaining){
    return allowancee[_owner][_spender];
  }


}
