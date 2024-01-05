// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    
    address public USER = makeAddr("User");
    string public constant BEAR = "ipfs://Qmagzt198Q5oxZ7njHFLzmJJqVXMwwBLybEc7TvWv7qPgz";
    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "AInimal";
        string memory actualName = basicNFT.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHasBalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(BEAR);
        
        assert(basicNFT.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(BEAR)) == keccak256(abi.encodePacked(basicNFT.tokenURI(0))));
    }
}

