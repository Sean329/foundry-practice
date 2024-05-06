// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {Error} from "../src/Error.sol";


contract TestError is Test {
    Error public error;

    function setUp() public {
        error = new Error();
    }

    function testFail() public view {
        error.throwError();
    }

    function test_revert_throwError() public {
        vm.expectRevert(bytes("not authorized"));
        error.throwError();
    }

    function test_revert_throwCustomerError() public {
        vm.expectRevert(Error.NotAuthorized.selector);
        error.throwCustomerError();
    }
}