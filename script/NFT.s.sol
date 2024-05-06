// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract TokenScript is Script {
    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");
        address firstOwner = vm.addr(privateKey);

        console.log(firstOwner);

        vm.startBroadcast(privateKey);
        MyNFT myNFT = new MyNFT(firstOwner);
        myNFT.mint(firstOwner, 0);

        vm.stopBroadcast();
    }
}
