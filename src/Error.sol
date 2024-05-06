// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.18;

contract Error {
    error NotAuthorized();

    function throwError() external pure {
        require(false, "not authorized");
    }

    function throwCustomerError() external pure {
        revert NotAuthorized();
    }
}