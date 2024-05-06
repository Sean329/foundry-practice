pragma solidity ^0.8.18;

import {Wallet} from "../src/Wallet.sol";
import {Test, console} from "forge-std/Test.sol";

contract TestWallet is Test {
    Wallet public wallet;
    event Deposit(address indexed account, uint256 amount);
    receive() payable external {}

    function setUp() public {
        // deal(address(this), 100 ether);
        wallet = new Wallet{value: 10 ether}();
    }

    function _send(uint256 _amount) internal {
        (bool success, ) = address(wallet).call{value: _amount}("");
        require(success, 'send ETH failed');
    }

    function test_withdraw() public {
        uint256 balanceBefore = address(wallet).balance;
        wallet.withdraw(1 ether);
        uint256 balanceAfter = address(wallet).balance;
        assertEq(balanceBefore - balanceAfter , 1 ether);
    }

    function test_revert_withdraw() public {
        address alice = makeAddr("alice");
        vm.prank(alice);
        vm.expectRevert();
        wallet.withdraw(1 ether);
    }

    function test_ETHBalance() public {
        console.log("ETH Balance: " , address(this).balance / 1 ether);
    }

    function test_send() public {
        address alice = makeAddr("alice");
        hoax(alice, 100 ether);
        

        vm.expectEmit(true, false, false, true);
        emit Deposit(alice, 50 ether);
        _send(50 ether);
    }
    
}
