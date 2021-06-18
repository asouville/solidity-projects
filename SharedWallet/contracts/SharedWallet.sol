// "SPDX-License-Identifier: MIT"

pragma solidity ^0.8.4;

import "./Allowance.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SharedWallet is Allowance {
    
    using SafeMath for uint;
    
    event MoneyDeposit(address _from, uint _amount);
    event MoneyWithdraw(address _to, uint _amount);
    
    receive() external payable {
        deposit();  
    }
    
    function deposit() payable public {
        emit MoneyDeposit(msg.sender, msg.value);
    }
    
    function withdraw(uint _amount) public ownerOrAllowed {
        require(_amount <= allowance[msg.sender], "Value not allowed");
        allowance[msg.sender].sub(_amount);
        address payable _to = payable(msg.sender) ; 
        emit MoneyWithdraw(_to, _amount);
        _to.transfer(_amount);
    }
    
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}
