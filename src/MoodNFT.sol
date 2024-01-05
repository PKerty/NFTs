// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {

    uint256 private s_tokenCounter;
    string private s_sadSVGUri;
    string private s_happySVGUri;

    error MoodNFT__NotAuthorizedCall();
    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSVGUri, string memory happySVGUri) ERC721("MoodNFT", "MN") {
        s_tokenCounter = 0;
        s_sadSVGUri = sadSVGUri;
        s_happySVGUri = happySVGUri;
    }
    function mintNFT() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns(string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory) {
        string memory imageUri;
        Mood mood = s_tokenIdToMood[tokenId];
        if(mood == Mood.HAPPY) {
            imageUri = s_happySVGUri;
        } else if(mood == Mood.SAD) {
            imageUri = s_sadSVGUri;
        }

        return string(
            abi.encodePacked( _baseURI(),
                             Base64.encode(
                                 bytes(
                                     abi.encodePacked(
                                         '{"name": "', name(),'",',
                                             '"description":"An NFT that reflects it\'s owner mood.",',
                                             '"attributes":[{"trait_type":"moodines","value":100}],',
                                             '"image":"', imageUri,'"}' 
                             )
                             )
                             )
                            )
        );
    }
    
    function flipMood(uint256 tokenId) public {
        if(!_isAuthorized(_ownerOf(tokenId),msg.sender, tokenId)) {
            revert MoodNFT__NotAuthorizedCall();  
        }
        s_tokenIdToMood[tokenId] = s_tokenIdToMood[tokenId] == Mood.HAPPY ? Mood.SAD:Mood.HAPPY;        
    }
}
