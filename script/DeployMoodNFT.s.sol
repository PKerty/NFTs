// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {MoodNFT} from "../src/MoodNFT.sol";

import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    

    function run() external returns(MoodNFT){
        string memory sadSvg= vm.readFile("./img/sad.svg");
        string memory happySvg= vm.readFile("./img/happy.svg");
        console2.log("sadSVG: ", sadSvg);
        console2.log("happySVG: ", happySvg);
        vm.startBroadcast();
        MoodNFT mood = new MoodNFT(svg2imgUri(sadSvg), svg2imgUri(happySvg));
        vm.stopBroadcast();
        return mood;
    }

    function svg2imgUri(string memory svg) public pure returns(string memory) {
        string memory prefixUri = "data:image/svg+xml;base64,";
        string memory encodedSvg = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(prefixUri,encodedSvg));
    }

}
