// "SPDX-License-Identifier: MIT"

pragma solidity ^0.8.4;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    
    event userAllowed(address _user, uint _size);
    
    mapping (address => uint) allowance;
    
    modifier ownerOrAllowed() {
        require(address(msg.sender) == owner() || allowance[msg.sender] > 0, "You are not allowed");
        _;
    }
    
    function renounceOwnership() public view override onlyOwner {
        revert("can't renounceOwnership here");
    }
    
    function getAllowance() public view returns (uint) {
        return allowance[msg.sender];
    }
    
    function allowUser(address _address, uint _size) public onlyOwner {
        emit userAllowed(_address, _size);
        allowance[_address] =  _size;
    }
}
