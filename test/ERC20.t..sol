// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ERC20Test} from "../src/ERC20.sol";

contract TokenTest is Test {
    ERC20Test public token;
    address public User2;
    address public User3;

    function setUp() public {
        token = new ERC20Test();
        User2 = address(0x1);
        User3 = address(0x2);
        vm.deal(User2, 1 ether);
        vm.deal(User3, 1 ether);
    }

    function test_Minting() public {
        uint256 amount = 2000 * 1e18;
        uint256 BalanceBeforeTransfer = token.balanceOf(address(this));
        uint256 BalanceShouldBe = BalanceBeforeTransfer + amount;
        token.mint(address(this), amount);
        uint256 balanceAfterMint = token.balanceOf(address(this));
        assertEq(balanceAfterMint, BalanceShouldBe);
    }

    function test_EnteringMoreToken() public {
        uint256 amount = 9999 * 1e18;
        uint256 BalanceChecker = token.balanceOf(address(this)) + amount;
        token.mint(address(this), amount);
        uint256 AfterMint = token.balanceOf(address(this));
        assertEq(AfterMint, BalanceChecker);
    }

    function test_sendingTokens() public {
        uint256 amount = 1000 * 1e18;
        token.mint(address(this), amount);
        token.transfer(User2, amount);
        uint256 BalanceOfUser2 = token.balanceOf(User2);
        assertEq(BalanceOfUser2, amount);
    }

    function test_AllowanceVerifier() public {
        uint256 amount = 1000 * 1e18;
        token.mint(address(this), amount);
        token.approve(User2, amount);
        uint256 AllowanceCheck = token.allowance(address(this), User2);
        assertEq(AllowanceCheck, amount);
    }

    function test_TransferFromWithAllowance() public {
        uint256 amount = 1000 * 1e18;
        token.mint(address(this), amount);
        token.approve(User2, amount);

        vm.prank(User2);
        token.transferFrom(address(this), User3, amount);

        assertEq(token.balanceOf(User3), amount);
        assertEq(token.allowance(address(this), User2), 0);
    }

    function test_TransferOwnership() public {
        token.transferOwnership(User2);
        assertEq(token.owner(), User2);
    }
}
