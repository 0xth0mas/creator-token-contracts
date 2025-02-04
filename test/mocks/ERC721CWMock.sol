// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "../../contracts/erc721c/extensions/ERC721CW.sol";

contract ERC721CWMock is ERC721CW {
    
    constructor(address wrappedCollectionAddress_) ERC721CW(wrappedCollectionAddress_, "ERC-721C Mock", "MOCK") {}

    function mint(address /*to*/, uint256 tokenId) external {
        stake(tokenId);
    }
}