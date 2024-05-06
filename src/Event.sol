pragma solidity ^0.8.18;

contract Event {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address _from, address _to, uint256 _amount) public {
        emit Transfer(_from, _to, _amount);
    }

    function transferMany(address _from, address[] calldata _to, uint256[] calldata _amounts) public {
        uint256 length = _to.length;
        for(uint256 i=0; i<length; ++i) {
            emit Transfer(_from, _to[i], _amounts[i]);
        }
    }
}