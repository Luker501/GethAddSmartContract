pragma solidity ^0.5.0;

contract HelloWorldContract {
    string word = 'Hello World';
    
    function getWord() public view returns(string memory) {
        return word;
    }
    
    function setWord(string memory newWord) public returns(string memory) {
        word = newWord;
        return word;
    }
    
}
