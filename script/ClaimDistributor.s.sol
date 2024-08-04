// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {MerkleDistributor} from "../src/airdrop/MerkleDistributor.sol";
import "../src/Tester.sol";

contract ClaimDistributorScript is Script {
    address merkleAddress = 0x18ab60FABe40A15236f39Fa5547a46b6221B71C9;
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new MerkleDistributor(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23);
        vm.stopBroadcast();
    }

    function withdraw() public {
        // v1: 0x9EC4a2FB40f49Cb9e438A470e3828ABE90AE5eC0
        vm.startBroadcast();
        MerkleDistributor(payable(merkleAddress)).withdraw();
        vm.stopBroadcast();
    }

    function setMerkleRoot() public {
        vm.startBroadcast();
        MerkleDistributor(payable(merkleAddress)).setMerkleRoot(0, 0x6acb2828c93eee09cf53f9e373972a3a9d1a5f3c0da415b6f166319bac465ed6);
        vm.stopBroadcast();
    }

    function printAll() public view {
        bytes32 root = MerkleDistributor(payable(merkleAddress)).merkleRoots(0);
        console2.logBytes32(root);
    }

    function tester() public {
        vm.startBroadcast();
        new Tester();
        vm.stopBroadcast();
    }
}
