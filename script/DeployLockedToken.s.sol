// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {LockedToken} from "../src/LockedToken.sol";

contract DeployLockedTokenScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        LockedToken token = new LockedToken();
        console2.log(address(token));
        vm.stopBroadcast();
    }
}
