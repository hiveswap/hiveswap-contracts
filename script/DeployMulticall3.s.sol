// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import {Script, console2} from "forge-std/Script.sol";
import {Multicall3} from "../src/Multicall3.sol";

contract DeployMulticall3Script is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Multicall3 token = new Multicall3();
        console2.log(address(token));
        vm.stopBroadcast();
    }
}
