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

    // epoll => root
    mapping(uint256 => bytes32) public merkleRoots;

    // epoll => index => claimed
    mapping(uint256 => mapping(uint256 => bool)) public claimedMap;

    error AlreadyClaimed();

    error InvalidProof();

    error WrongEpoll();

    error WrongClaimsInput();

    // This event is triggered whenever a call to #claim succeeds.
    event Claimed(uint256 epoll, uint256 index, address account, uint256 amount);

    constructor(address _token) Ownable(msg.sender) {
        token = _token;
    }

    function setMerkleRoot(uint256 epoll, bytes32 _merkleRoot) public onlyOwner {
        merkleRoots[epoll] = _merkleRoot;
    }

    function claim(uint256 epoll, uint256 index, address account, uint256 amount, bytes32[] calldata merkleProof) public {
        if (merkleRoots[epoll] == bytes32(0)) {
            revert WrongEpoll();
        }

        if (claimedMap[epoll][index]) {
            revert AlreadyClaimed();
        }

        bytes32 node = keccak256(abi.encodePacked(index, account, amount));
        if (!MerkleProof.verify(merkleProof, merkleRoots[epoll], node)) {
            revert InvalidProof();
        }

        claimedMap[epoll][index] = true;

//        IERC20(token).transfer(account, amount);
        IWETH(token).withdraw(amount);
//        payable(account).transfer(amount);
        (bool success, ) = account.call{value: amount}("");
        require(success, "Transfer failed");

        emit Claimed(epoll, index, account, amount);
    }

    function claims(
        uint256[] calldata epolls,
        uint256[] calldata indexes,
        address[] calldata accounts,
        uint256[] calldata amounts,
        bytes32[][] calldata merkleProofs
    ) public {
        if (epolls.length != indexes.length ||
            epolls.length != amounts.length ||
            epolls.length != merkleProofs.length ||
            epolls.length != accounts.length) {
            revert WrongClaimsInput();
        }

        for (uint256 i = 0; i < epolls.length; i++) {
            if (!claimedMap[epolls[i]][indexes[i]]) {
                claim(epolls[i], indexes[i], accounts[i], amounts[i], merkleProofs[i]);
            }
        }
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
