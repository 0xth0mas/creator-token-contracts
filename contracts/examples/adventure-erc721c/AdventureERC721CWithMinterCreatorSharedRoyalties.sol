// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../erc721c/AdventureERC721C.sol";
import "../../programmable-royalties/MinterCreatorSharedRoyalties.sol";

contract AdventureERC721CWithMinterCreatorSharedRoyalties is AdventureERC721C, MinterCreatorSharedRoyalties {

    constructor(
        uint256 royaltyFeeNumerator_,
        uint256 minterShares_,
        uint256 creatorShares_,
        address creator_,
        uint256 maxSimultaneousQuests_,
        string memory name_,
        string memory symbol_) 
        AdventureERC721C(maxSimultaneousQuests_, name_, symbol_) 
        MinterCreatorSharedRoyalties(royaltyFeeNumerator_, minterShares_, creatorShares_, creator_) {
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AdventureERC721C, MinterCreatorSharedRoyalties) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId) external {
        _safeMint(to, tokenId);
    }

    function burn(uint256 tokenId) external {
        _burn(tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override {
        _onMinted(to, tokenId);
        super._mint(to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
        _onBurned(tokenId);
    }
}
