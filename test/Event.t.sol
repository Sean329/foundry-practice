pragma solidity ^0.8.18;

import {Event} from "../src/Event.sol";
import {Test, console} from "forge-std/Test.sol";

contract TestEvent is Test {
    Event public e;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        e = new Event();
    }

    function test_transfer() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), address(1), 2);
        e.transfer(address(this), address(1), 2);
    }

    function test_transferMany() public {
        address[] memory _to = new address[](2);
        _to[0] = address(1);
        _to[1] = address(2);

        uint256[] memory _amounts = new uint256[](2);
        _amounts[0] = 777;
        _amounts[1] = 888;

        for(uint256 i; i < _to.length; ++i) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), _to[i], _amounts[i]);
            
        }

        e.transferMany(address(this), _to, _amounts);

    }
}