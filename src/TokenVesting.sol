// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenVesting {
    IERC20 public token;
    uint256 public vestingDuration = 270 days; // 9 months
    uint256 public vestingStart;
    mapping(address => uint256) public totalAllocation;
    mapping(address => uint256) public claimed;

    constructor(address _token) {
        token = IERC20(_token);
        vestingStart = block.timestamp;
    }

    function setAllocation(address[] memory users, uint256[] memory amounts) external {
        require(users.length == amounts.length, "Arrays length mismatch");
        for (uint i = 0; i < users.length; i++) {
            totalAllocation[users[i]] = amounts[i];
        }
    }

    function claimableAmount(address user) public view returns (uint256) {
        if (block.timestamp < vestingStart) {
            return 0;
        }

        uint256 totalVested = totalAllocation[user];
        if (totalVested == 0) {
            return 0;
        }

        uint256 initialRelease = totalVested * 10 / 100;
        uint256 vestedAmount = initialRelease;

        if (block.timestamp >= vestingStart + vestingDuration) {
            return totalVested - claimed[user];
        }

        uint256 timeElapsed = block.timestamp - vestingStart;
        uint256 linearVestingAmount = (totalVested - initialRelease) * timeElapsed / vestingDuration;

        vestedAmount = vestedAmount + linearVestingAmount;

        return vestedAmount - claimed[user];
    }

    function claim() external {
        uint256 amount = claimableAmount(msg.sender);
        require(amount > 0, "Nothing to claim");

        claimed[msg.sender] = claimed[msg.sender] + amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }
}
