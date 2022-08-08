pragma solidity >=0.4.22 <0.9.0;

/**
* @title Nirvana
* @dev Accept customer deposits and allow merchant withdrawals. A customer is allowed to deposit 100 milliether per collateral.
*/

contract NirvanaPaymentChannel{

uint256 p_nonce; //indicates payment nonce. Used by Customers to make multiple payments to merchants. 
 //uint256 secrets_required;
address owner;
address payable[] merchants_in_network;
 
struct Customer{
    bool exists;
    uint256 customer_collateral;
    uint256 duration;
    //bytes32[] secret_hashes;
}

struct Merchant{
    bool exists;
    uint256 earnings;
}
mapping(address => Customer) public customers;
mapping(address => Merchant) public merchants; 
 
constructor () public {
    owner = msg.sender;
 
}
 
modifier onlyOwner { require(msg.sender == owner, 'Only Nirvana can call this function.'); _;}
 

 
 
function registerCustomer() public payable{
    
    customers[msg.sender].customer_collateral = msg.value;
    customers[msg.sender].exists = true;
    customers[msg.sender].duration = block.timestamp; 
   
}
 
function add_merchants(address payable[] memory _merchantAddresses) public onlyOwner{
    merchants_in_network = _merchantAddresses;
    for(uint i=0; i<merchants_in_network.length; i++){
        merchants[merchants_in_network[i]].exists = true;
        merchants[merchants_in_network[i]].earnings = 0;
    }
}
 

 
}