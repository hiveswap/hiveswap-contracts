// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IMasterChefV3 {
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

    function latestPeriodEndTime() external view returns (uint256);

    function latestPeriodStartTime() external view returns (uint256);

    function upkeep(uint256 amount, uint256 duration, bool withUpdate) external;

    function add(uint256 _allocPoint, address _v3Pool, bool _withUpdate) external;

    function owner() external view returns (address);

    function receiver() external view returns (address);

    function LMPoolDeployer() external view returns (address);

    function setLMPoolDeployer(address) external;

    function setReceiver(address) external;

    function poolInfo(uint256) external view returns (PoolInfo memory);

    function CAKE() external view returns (address);
}
