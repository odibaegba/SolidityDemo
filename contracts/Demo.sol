// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
//Import External Contracts

contract Demo {
    uint public score;
    
    function getAnswer() public {
        uint a = 1;
        uint b = 2;
        uint ans = a + b;

        score = getRoot(ans);
    }

    function getRoot(uint ans) internal pure returns (uint) {
        return ans * ans; // Corrected to square the number
    }
}

contract IdCard{
    string public fullname;
    uint256 public age;
    string public gender;
    address public id;
    uint256 public registeredAt;

    constructor(string memory _gender){
        uint256 _age = 25;
        age = _age;
        gender = _gender;
        id = msg.sender;
        registeredAt = block.timestamp;
    }
}

contract Payment{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function withdrawTo() public view returns (bool){
        require(msg.sender == owner, "Admin only!");

        return true;
    }

}

contract Payer is Payment {
    constructor() {}

    function getOwner() public view returns(address) {
        return owner;
    }
}

contract Caller{
    Payer person = new Payer();

    function getResult() public view returns(address){
        return  person.getOwner();
    }
}

contract PracticeEnum{

order public status;

    enum order {
        PLACED,
        SHIPPED,
        DELIVERED,
        RETURNED
    }

    function markAsDelivered() public {
        status = order.DELIVERED;
    }
}

contract PracticeStruct{

productStruct public items;

    struct productStruct{
        uint id;
        address owner;
        string name;
        uint price;
        uint256 createdAt;
        bool deleted;
    }

    function createProduct() public {
        items = productStruct(
            1,
            0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            "Raven",
            1 ether,
            block.timestamp,
            false
        );
    }
}

contract ArethemeticOp{
    function addNum(int num1, int num2) public pure returns(int){
        return num1 + num2;
    }

    function incNum(int num1, int num2) public pure returns(int){
        int result = num1 + num2;
        result++;

        return result;
    }
}

contract RelationalData{
    function isEqualTo(int number1, int number2) public pure returns(bool){
        return  number1 == number2;
    }

    function isGreaterThan(int number1, int number2) public pure returns(bool){
        return  number1 > number2;
    }

    function isLesserThan(int number1, int number2) public pure returns(bool){
        return  number1 < number2;
    }

    function isGreaterThanOr(int number1, int number2) public pure returns(bool){
        return  number1 >= number2;
    }

    function isNotEqual(int number1, int number2) public pure returns(bool){
        return  number1 != number2;
    }
}

contract ConditionalOpr{
    function tenaryOpr(int num1, int num2)public pure returns(int){
        int result = num1 > num2 ? num1 - num2 : num2 - num1;
        return result;
    }
}

contract Testing{
    address public owner;
    // address public account;
    // uint256 public balance;

    constructor(){
        owner = msg.sender;
    }

    // this is for receiving money into my wallet
    function receiveMoney() public payable returns(bool){
        require(msg.value > 0 ether, "Add Some Money");
        //balance += msg.value;

        return true;
    }

    //this is a sample for sending out moneey from my wallet to another
    function sendMoney(address payable  _account, uint256 _amount) public returns(bool){
        require(address(this).balance  > _amount, "Insufficient Funds");
        _account.transfer(_amount);
        //send money...

        return true;
    }

    //this is to get a count and the balance of that account
    function getAccount() public view returns(address, uint256)
    {
        address acc = address(this);
        uint256 bal = acc.balance;

        return(acc, bal);
    }

    // function getBalance() public view returns (uint256, address)
    // {
    //     return(balance, account);
    // }

     
}

contract ArrayTypes{
    uint256[] fixedArray = [0,1,2,3,4,5,6];
    uint256[] dynArray = [0,1,2,3,4,5,6,7,8,9,10,11];
    string[] names = ["Stephen", "Faith", "Miles", "Robbert", "Becky"]; 
 
    function getFixedArray() public view returns(uint256[] memory){
        return fixedArray;
    }

    function getDynArray() public view returns(uint256[] memory){
        return dynArray;
    }

    function getPush(string memory _name) public returns(bool){
        names.push(_name);
        return true;
    }

    function getArrayNAmeValues() public view returns(string[] memory){
        return names;
    }

    function getArrayName(uint256 index) public view returns(string memory){
        return names[index];
    }
}

contract MappingInSolidity{
    mapping(address => uint256) public balanceOf; 

    function donate() public payable{
        balanceOf[msg.sender] += msg.value;
    }
} 

contract ConditionalTest{
    mapping(address => uint256) public contributions;
    mapping(address => bool) public stakeholder;
    mapping(address => bool) public firstTimer;

    function donate2() public payable{
        if(contributions[msg.sender] == 2){
            stakeholder[msg.sender] = true;
            contributions[msg.sender] += 1;
        }
        else if(contributions[msg.sender] == 0){
            firstTimer[msg.sender] = true;
            contributions[msg.sender] += 1;
        }
        else{
            firstTimer[msg.sender] = false;
            contributions[msg.sender] += 1; 
        }
    }
}

contract RequireDemo{
    uint public share = 5;
    address owner;

    constructor(){
        owner = msg.sender;
    }

    function withoutRequired(uint _share) public {
        share = _share;
    }

    function withRequired(uint _share) public{
        require(msg.sender == owner, "Unauthorized");
        share = _share;
    }
}

contract Iterators{
    uint private whileRes;
    uint private doWhileRes;
    uint private forRes;

    function whileLoop() public returns (bool){
        uint i = 0;
        whileRes = 0;
        while(i < 5){
            i ++;
            whileRes ++;
        }
        return true;
    } 

    function doWhileLoop() public returns(bool){
        uint i = 0;
        doWhileRes = 0;
        do{
            doWhileRes ++;
            i ++;
        }
        while(i < 5);
        return  true;
    }

    function forLoop() public returns(bool){
        for(uint i = 0; i < 5; i++)
        {
            forRes++;
        }
        return true;
    }

    function returnResult() public view returns(uint, uint, uint){
        return (whileRes, doWhileRes, forRes);
    }
}

contract FuncModifiers{
    address private owner;

    constructor(){
        owner = msg.sender;
    }

    modifier  ownerOnly(string memory message){
         require(msg.sender == owner, message);
         _;
    }

    function withdraw() external view ownerOnly("Unauthorized access") returns(address){
       
        return owner;
    }
}

contract NewsMan{
    string[] private news;

    event Published(
        uint indexed nid,
        address indexed publisher,
        string speech,
        uint timestamp
    );

    function publishNews(string calldata speech) public returns(bool){
        news.push(speech);

        emit Published(
            news.length,  //+ 1, this helkps us to assign an id to each news .
            msg.sender,
            speech,
            block.timestamp
        );

        return true; 
    }

    function returnPublishedNews()public view returns(string[] memory){
        return news;
    } 
}

