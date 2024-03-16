// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-ctf/src/CTFDeployment.sol";

import "../src/spaceBank/Challenge.sol";
import "../src/spaceBank/SpaceBank.sol";

contract Deploy is CTFDeployment {
    function deploy(address system, address) internal override returns (address challenge) {
        vm.startBroadcast(system);

        SpaceToken token = new SpaceToken();

        SpaceBank spacebank = new SpaceBank(address(token));

        token.mint(address(spacebank), 1000);

        challenge = address(new Challenge(spacebank));

        vm.stopBroadcast();
    }
}
