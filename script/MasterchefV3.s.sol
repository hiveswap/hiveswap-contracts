// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {MakaluToken} from "../src/MakaluToken.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IPancakeV3Factory} from "../src/interfaces/IPancakeV3Factory.sol";
import {IMasterChefV3} from "../src/interfaces/IMasterChefV3.sol";
import {IPancakeV3Pool} from "../src/interfaces/IPancakeV3Pool.sol";

contract MasterchefV3 is Script {
    function setUp() public {}

    struct PoolInfo {
        uint256 allocPoint;
        // V3 pool address
        address v3Pool;
        // V3 pool token0 address
        address token0;
        // V3 pool token1 address
        address token1;
        // V3 pool fee
        uint24 fee;
        // total liquidity staking in the pool
        uint256 totalLiquidity;
        // total boost liquidity staking in the pool
        uint256 totalBoostLiquidity;
    }

    address hiveAddress = 0x01a960E07B25ea39B21F1E498722f19Fb3F0Ecc3;
    address wmap = 0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23;
    address mscV3 = 0xD1486812609948406097A9476F68C417990C9DbA;
    address factory = 0xFF53fAdeA915cac79b55D912fd373545B890f93B;

    function printAll() public view {
        console2.log("symbol", IERC20Metadata(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23).symbol());
        console2.log("name", IERC20Metadata(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23).name());
        console2.log("MscV3 owner: ", IMasterChefV3(mscV3).owner());
        console2.log("Receiver: ", IMasterChefV3(mscV3).receiver());
        console2.log("LMPoolDeployer", IMasterChefV3(mscV3).LMPoolDeployer());
        IMasterChefV3.PoolInfo memory pi = IMasterChefV3(mscV3).poolInfo(1);
        console2.log("pool 1", pi.v3Pool);

        address pool = IPancakeV3Factory(factory).getPool(hiveAddress, wmap, 2500);
        console2.log("Hive-Map Pool: ", pool);
        console2.log("symbol ", IERC20Metadata(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23).symbol());
        console2.log("name ", IERC20Metadata(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23).name());
        console2.log("decimals ", IERC20Metadata(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23).decimals());
        (
            uint160 sqrtPriceX96,
            int24 tick,
            uint16 observationIndex,
            uint16 observationCardinality,
            uint16 observationCardinalityNext,
            uint32 feeProtocol,
            bool unlocked
        ) = IPancakeV3Pool(pool).slot0();
        console2.log("slot0 sqrtPriceX96", sqrtPriceX96);
        console2.log("slot0 tick", tick);
        console2.log("slot0 feeProtocol", feeProtocol);
        console2.log("slot0 unlocked", unlocked);
        console2.log("Cake: ", IMasterChefV3(mscV3).CAKE());
    }
    function printProtocolFees() public view  {
        (uint128 t0, uint128 t1) = IPancakeV3Pool(0xd07458850b575535d79F30Cd879C8685B686d812).protocolFees();
        console2.log("protocolFees: ", t0, t1);
//        address owner = IPancakeV3Factory(factory).owner();
//        console2.log(owner);
    }

    function send() public {
        vm.startBroadcast();
        address owner = IPancakeV3Factory(0xFF53fAdeA915cac79b55D912fd373545B890f93B).owner();
        console2.log(owner);
        console2.log(msg.sender);
        IPancakeV3Factory(0xFF53fAdeA915cac79b55D912fd373545B890f93B).setOwner(0x79D136eA683F52ADEc7A264CdBdf85f5CbFb73E4);
        vm.stopBroadcast();
    }

    function collectProtocol() public {
        vm.startBroadcast();
        IPancakeV3Factory(factory).collectProtocol(0x39659129b33A71B745Cb7969BDD5E524665c1061, 0x50721FA72783D42D54e17b17546960305Aa7F626, 19500000000000, 0);
//        IPancakeV3Pool(0x10b8C60B45191C2E32a5AC7AC604Ac3807dEa48A).collectProtocol(0x0e367ce43859B170EF7DC147CE83e2e5ea8A6fbe, 19500000000000, 0);
        vm.stopBroadcast();
    }

    function add() public {
        vm.startBroadcast();

        console2.log(msg.sender);
        IMasterChefV3(mscV3).add(10000, 0x10b8C60B45191C2E32a5AC7AC604Ac3807dEa48A, false);

        vm.stopBroadcast();
    }

    function upkeep() public {
        vm.startBroadcast();

        console2.log(msg.sender);
        IMasterChefV3(mscV3).upkeep(10000 ether, 7 * 3600 * 24, false);

        vm.stopBroadcast();
    }

    function prepare() public  {
        vm.startBroadcast();

        IMasterChefV3(mscV3).setLMPoolDeployer(0x373118B4077358BF3495c4c6f9f5D9640453C476);
        IERC20(hiveAddress).approve(mscV3, type(uint256).max);
        IMasterChefV3(mscV3).setReceiver(0x0e367ce43859B170EF7DC147CE83e2e5ea8A6fbe);

        vm.stopBroadcast();
    }
}
