// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../utils/CreatorTokenBase.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/**
 * @title ERC1155C
 * @author Limit Break, Inc.
 * @notice Extends OpenZeppelin's ERC1155 implementation with Creator Token functionality, which
 *         allows the contract owner to update the transfer validation logic by managing a security policy in
 *         an external transfer validation security policy registry.  See {CreatorTokenTransferValidator}.
 */
abstract contract ERC1155C is ERC1155, CreatorTokenBase {
    
    constructor(string memory uri_) CreatorTokenBase() ERC1155(uri_) {}

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(ICreatorToken).interfaceId || super.supportsInterface(interfaceId);
    }

    /// @dev Ties the open-zeppelin _beforeTokenTransfer hook to more granular transfer validation logic
    function _beforeTokenTransfer(
        address /*operator*/,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory /*amounts*/,
        bytes memory /*data*/
    ) internal virtual override {
        uint256 idsArrayLength = ids.length;
        for (uint256 i = 0; i < idsArrayLength;) {
            _validateBeforeTransfer(from, to, ids[i]);

            unchecked {
                ++i;
            }
        }
    }

    /// @dev Ties the open-zeppelin _afterTokenTransfer hook to more granular transfer validation logic
    function _afterTokenTransfer(
        address /*operator*/,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory /*amounts*/,
        bytes memory /*data*/
    ) internal virtual override {
        uint256 idsArrayLength = ids.length;
        for (uint256 i = 0; i < idsArrayLength;) {
            _validateAfterTransfer(from, to, ids[i]);

            unchecked {
                ++i;
            }
        }
    }
}
