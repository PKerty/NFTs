// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {MoodNFT} from "../../src/MoodNFT.sol";

import {DeployMoodNFT} from "../../script/DeployMoodNFT.s.sol";

contract DeployMoodTest is Test {
    DeployMoodNFT deployer;
    function setUp() public {
        deployer = new DeployMoodNFT();
    }

    function testSvg2Uri() public view { 
        string memory expectedUri = 'data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjEwMCIgd2lkdGg9IjEwMCI+PGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMyIgZmlsbD0icmVkIiAvPjwvc3ZnPg==';
        string memory svg =  '<svg height="100" width="100"><circle cx="50" cy="50" r="40" stroke="black" stroke-width="3" fill="red" /></svg>';
        string memory encoded = deployer.svg2imgUri(svg);
        /*
        console2.log(expectedUri);
        console2.log(encoded);
        */
        assert(keccak256(abi.encodePacked(expectedUri)) == keccak256(abi.encodePacked(encoded)));
    }
}
