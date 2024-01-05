// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {BasicNFT} from "../src/BasicNFT.sol";

import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";


contract Interactions is Script {
    
    string public constant BEAR = "ipfs://Qmagzt198Q5oxZ7njHFLzmJJqVXMwwBLybEc7TvWv7qPgz";

    function run() external {
        address mostRecentDeploy = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        mintNFTOnContract(mostRecentDeploy);
    }
    function mintNFTOnContract(address contractAddr) public {
        vm.startBroadcast();
        BasicNFT(contractAddr).mintNFT(BEAR);
        vm.stopBroadcast();
    }
}
