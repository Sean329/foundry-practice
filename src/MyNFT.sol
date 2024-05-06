// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    constructor(address _firstOwner) ERC721("MyNFT", "MNFT") Ownable(_firstOwner) {}

    function mint(address _to , uint _tokenId) external onlyOwner {
        _mint(_to , _tokenId);
    }
}