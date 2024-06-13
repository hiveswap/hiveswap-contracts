// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {MerkleDistributor} from "../src/airdrop/MerkleDistributor.sol";
import "../src/Tester.sol";

contract MerkleDistributorScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new MerkleDistributor(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23, 0x4eebe2bbd5da7dcbc0c824752402e5bd93491015daad17eed203d114a1036d66);
        vm.stopBroadcast();
    }

    function withdraw() public {
        // v1: 0x9EC4a2FB40f49Cb9e438A470e3828ABE90AE5eC0
        vm.startBroadcast();
        MerkleDistributor(payable(0x060eB35AD1105Ba022083D1f6c5451A884A57824)).withdraw();
        vm.stopBroadcast();
    }

    function printAll() public {
        bytes32 root = MerkleDistributor(payable(0x9EC4a2FB40f49Cb9e438A470e3828ABE90AE5eC0)).merkleRoot();
        console2.logBytes32(root);
    }

    function tester() public {
        vm.startBroadcast();
        new Tester();
        vm.stopBroadcast();
    }
}
