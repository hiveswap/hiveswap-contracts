// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {MakaluToken} from "../src/MakaluToken.sol";

contract DeployMakaluTokenScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        MakaluToken token = new MakaluToken("Tether Token", "USDT");
        console2.log(address(token));
        vm.stopBroadcast();
    }
}
