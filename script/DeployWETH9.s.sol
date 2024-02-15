// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.6.6;

import {Script, console2} from "forge-std/Script.sol";
import {WETH9} from "../src/WETH9.sol";

contract DeployWETH9Script is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        WETH9 token = new WETH9();
        console2.log(address(token));
        vm.stopBroadcast();
    }
}
