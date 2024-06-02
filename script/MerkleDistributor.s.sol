// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {MerkleDistributor} from "../src/airdrop/MerkleDistributor.sol";

contract MerkleDistributorScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new MerkleDistributor(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23, 0x6759e8468ed28234850b0e6d9ad485bcc00f849b9f392b1c03ef77546ec63740);
        vm.stopBroadcast();
    }

    function withdraw() public {
        vm.startBroadcast();
        MerkleDistributor(0xC5881DAa6D8B6010A195D03057e052D352cc9F50).withdraw();
        vm.stopBroadcast();
    }
}
