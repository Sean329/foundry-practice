// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }
    
    function testFail_increment() public {
        counter.increment();
        assertEq(counter.number(), 2);
    }

    function test_revert_decrement() public {
        vm.expectRevert();
        counter.decrement();
    }
}
