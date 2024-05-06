pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";

interface IWETH {
    function balanceOf(address) external view returns (uint256);
    function deposit() external payable;
}

contract TestFork is Test {
    IWETH public weth;
    uint fork;

    function setUp() public {
        fork = vm.createFork("https://eth-mainnet.g.alchemy.com/v2/wb63iZ_wSGowLqNQsIN1GuPIdlViU4Cm");
        weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testDeposit() public {
        vm.selectFork(fork);

        uint balanceBefore = weth.balanceOf(address(this));
        console.log("Balance before is: %e", balanceBefore / 1 ether);

        weth.deposit{value: 1 ether}();

        uint balanceAfter = weth.balanceOf(address(this));
        console.log("Balance after is: %e", balanceAfter / 1 ether);

        assertEq(balanceAfter, 1 ether);
    }
}