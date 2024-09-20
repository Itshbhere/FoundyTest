// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ERC20Test} from "../src/ERC20.sol";

contract CounterScript is Script {
    ERC20Test public token;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        token = new ERC20Test();

        vm.stopBroadcast();
    }
}
