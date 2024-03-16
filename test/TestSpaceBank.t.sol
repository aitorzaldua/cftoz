// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {SpaceBank} from "./../src/spaceBank/SpaceBank.sol";
import {Challenge} from "./../src/spaceBank/Challenge.sol";
import {SpaceToken} from "./../src/spaceBank/SpaceToken.sol";

contract TestSpaceBank is Test {
    /////////////
    // USERS ////
    /////////////

    address DEPLOYER = makeAddr("deployer");
    address USER1 = makeAddr("user1");

    //////////////////
    // CONTRACTS ////
    /////////////////

    SpaceBank spacebank;
    Challenge challenge;
    SpaceToken token;

    //////////////////
    // SETUP      ////
    /////////////////

    function setUp() external {
        vm.startPrank(DEPLOYER);
        token = new SpaceToken(DEPLOYER);
        spacebank = new SpaceBank(address(token));
        token.mint(address(spacebank), 1000);

        challenge = new Challenge(spacebank);
        vm.stopPrank();
    }

    function test_checkSetup() external {
        assertEq(1000, token.balanceOf(address(spacebank)));
        console.log("isSolved: ", challenge.isSolved());
    }

    modifier addTokensToUSER1() {
        vm.prank(DEPLOYER);
        token.mint(USER1, 1000);
        _;
    }

    //////////////////
    // TESTS      ////
    /////////////////

    function test_depositAndWithdraw() external addTokensToUSER1 {
        vm.prank(USER1);
        spacebank.flashLoan(200, USER1);
    }
}
