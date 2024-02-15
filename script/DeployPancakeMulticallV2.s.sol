// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

import {Script, console2} from "forge-std/Script.sol";
import {PancakeInterfaceMulticallV2} from "../src/PancakeInterfaceMulticallV2.sol";

contract DeployPancakeMulticallV2Script is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        PancakeInterfaceMulticallV2 token = new PancakeInterfaceMulticallV2();
        console2.log(address(token));
        vm.stopBroadcast();
    }
}
