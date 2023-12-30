// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/HiveToken.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        HiveToken token = new HiveToken();
        console2.log(address(token));
        vm.stopBroadcast();
    }
}
