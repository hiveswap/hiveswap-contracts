// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {MerkleDistributor} from "../src/airdrop/MerkleDistributor.sol";
import "../src/Tester.sol";

contract MerkleDistributorScript is Script {
    address merkleAddress = 0x2023Ccfd65cE64889fE450d34363539a1C7fdB99;
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new MerkleDistributor(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23);
        vm.stopBroadcast();
    }

    function withdraw() public {
        // v1: 0x9EC4a2FB40f49Cb9e438A470e3828ABE90AE5eC0
        vm.startBroadcast();
//        MerkleDistributor(payable(merkleAddress)).withdraw();
        MerkleDistributor(payable(merkleAddress)).withdrawMAPO();
        vm.stopBroadcast();
    }

    function setMerkleRoot() public {
        vm.startBroadcast();
        MerkleDistributor(payable(merkleAddress)).setMerkleRoot(3, 0x36f26ef4ac5d1bd18676a10f5a1ab3a4c37affa40bc32aea53513f7475177bb2);
        vm.stopBroadcast();
    }

    function printAll() public view {
        bytes32 root = MerkleDistributor(payable(merkleAddress)).merkleRoots(2);
        console2.logBytes32(root);
    }

    function tester() public {
        vm.startBroadcast();
        new Tester();
        vm.stopBroadcast();
    }
}
