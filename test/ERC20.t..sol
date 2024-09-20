// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ERC20Test} from "../src/ERC20.sol";

contract TokenTest is Test {
    ERC20Test public token; // Changed variable name to 'token' to match usage

    function setUp() public {
        token = new ERC20Test(); // Instantiate the correct contract
    }

    function test_Increment() public {
        uint256 amount = 2000 * 1e18; // Use 1e18 for proper ERC20 token units (assuming 18 decimals)
        token.mint(msg.sender, amount); // Mint tokens to the sender
        uint256 balanceAfterMint = token.balanceOf(msg.sender); // Get balance after minting
        assertEq(balanceAfterMint, amount); // Assert the balance equals the minted amount
    }

    function test_EnteringMoreToken() public {
        uint256 amount = 9999 * 1e18;
        uint256 BalanceChecker = token.balanceOf(msg.sender) + amount;
        token.mint(msg.sender, amount);
        uint256 AfterMint = token.balanceOf(msg.sender);
        assertEq(AfterMint, BalanceChecker);
    }
}
