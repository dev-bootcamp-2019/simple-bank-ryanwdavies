pragma solidity ^0.5.0;
contract SimpleBank {
    mapping (address => uint) private balances;
    mapping (address => bool) public enrolled;

    address payable public owner;
    
    event LogEnrolled(address indexed accountAddress); 
    event LogDepositMade(address indexed accountAddress, uint amount);
    event LogWithdrawal(address indexed accountAddress, uint withdrawAmount, uint newBalance);

    constructor() public { owner = msg.sender; }

    function balance() public view returns (uint) {
        return(balances[msg.sender]);  
    }   

    function enroll() public returns (bool){
        enrolled[msg.sender] = true;
        emit LogEnrolled(msg.sender);
        return(enrolled[msg.sender]);
    }

    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        owner.transfer(msg.value);
        emit LogDepositMade(msg.sender, msg.value);
        return(balances[msg.sender]);  
    }   

    function withdraw(uint withdrawAmount) public payable returns (uint) {
        require(balances[msg.sender] >= withdrawAmount);
        balances[msg.sender] -= withdrawAmount;
        msg.sender.transfer(withdrawAmount);
        emit LogWithdrawal(msg.sender, withdrawAmount, balances[msg.sender]);
        return(balances[msg.sender]);
    }   

    function() external {
        revert();
    }   
}
