pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";

contract TestSign is Test {
    function test_signature() public {
        uint privateKey = 123;
        address pubkey = vm.addr(privateKey);

        bytes32 msgHash = keccak256("secret msg");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, msgHash);

        address signer = ecrecover(msgHash, v, r, s);
        console.log(signer);
        assertEq(signer, pubkey);
    }
}