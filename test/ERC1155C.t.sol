// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "./mocks/ERC1155CMock.sol";
import "./CreatorTokenTransferValidatorERC1155.t.sol";

contract ERC1155CTest is CreatorTokenTransferValidatorERC1155Test {

    ERC1155CMock public tokenMock;

    function setUp() public virtual override {
        super.setUp();
        
        tokenMock = new ERC1155CMock();
        tokenMock.setToCustomValidatorAndSecurityPolicy(address(validator), TransferSecurityLevels.One, 1, 0);
    }

    function _deployNewToken(address creator) internal virtual override returns (ITestCreatorToken1155) {
        vm.prank(creator);
        return ITestCreatorToken1155(address(new ERC1155CMock()));
    }

    function _mintToken(address tokenAddress, address to, uint256 tokenId, uint256 amount) internal virtual override {
        ERC1155CMock(tokenAddress).mint(to, tokenId, amount);
    }

    function testSupportedTokenInterfaces() public {
        assertEq(tokenMock.supportsInterface(type(ICreatorToken).interfaceId), true);
        assertEq(tokenMock.supportsInterface(type(IERC1155).interfaceId), true);
        assertEq(tokenMock.supportsInterface(type(IERC1155MetadataURI).interfaceId), true);
        assertEq(tokenMock.supportsInterface(type(IERC165).interfaceId), true);
    }
}