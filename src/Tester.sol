// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IWETH {
    function withdraw(uint256) external;
}

contract Tester {
    constructor(){

    }

    function test(address account, uint256 amount) public {
        IWETH(0x13CB04d4a5Dfb6398Fc5AB005a6c84337256eE23).withdraw(amount);
//        payable(account).transfer(amount);
        // Transfer ETH to the account using call
        (bool success, ) = account.call{value: amount}("");
        require(success, "Transfer failed");
    }

    // Fallback function to receive ETH
    receive() external payable {}
}
