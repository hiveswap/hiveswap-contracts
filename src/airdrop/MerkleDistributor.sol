// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

interface IWETH is IERC20 {
    function withdraw(uint256) external;
}

contract MerkleDistributor is Ownable {
    address public immutable token;
    bytes32 public merkleRoot;

    mapping(uint256 => bool) public claimedMap;

    error AlreadyClaimed();

    error InvalidProof();

    // This event is triggered whenever a call to #claim succeeds.
    event Claimed(uint256 index, address account, uint256 amount);

    constructor(address _token, bytes32 _merkleRoot) Ownable(msg.sender) {
        token = _token;
        merkleRoot = _merkleRoot;
    }

    function setMerkleRoot(bytes32 _merkleRoot) public onlyOwner {
        merkleRoot = _merkleRoot;
    }

    function claim(uint256 index, address account, uint256 amount, bytes32[] calldata merkleProof) public {
        if (claimedMap[index]) {
            revert AlreadyClaimed();
        }

        bytes32 node = keccak256(abi.encodePacked(index, account, amount));
        if (!MerkleProof.verify(merkleProof, merkleRoot, node)) {
            revert InvalidProof();
        }

        claimedMap[index] = true;

//        IERC20(token).transfer(account, amount);
        IWETH(token).withdraw(amount);
//        payable(account).transfer(amount);
        (bool success, ) = account.call{value: amount}("");
        require(success, "Transfer failed");

        emit Claimed(index, account, amount);
    }

    function withdraw() public onlyOwner {
        IERC20(token).transfer(msg.sender, IERC20(token).balanceOf(address(this)));
    }

    function withdrawMAPO() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    // Fallback function to receive ETH
    receive() external payable {}
}
