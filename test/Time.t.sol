pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TestAuction is Test {
    Auction public auction;
    uint256 private startAt;

    function setUp() public {
        auction = new Auction();
    }

    function test_revert_bid() public {
        vm.warp(block.timestamp + 1 minutes);
        vm.expectRevert(bytes('cannot bid'));
        auction.bid();
    }

    function test_bid() public {
        vm.warp(block.timestamp + 1 minutes + 1 days);
        auction.bid();
    }

    function test_timeStamp() public {
        uint256 time = block.timestamp;
        console.log(time);

        skip(100 minutes);
        assertEq(block.timestamp, time + 100 minutes);

        rewind(50 minutes);
        assertEq(block.timestamp, time + 100 minutes - 50 minutes);
    }

    function test_blockNumber() public {
        uint256 b = block.number;
        vm.roll(100);
        assertEq(block.number, 100);
    }
}