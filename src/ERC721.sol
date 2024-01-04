// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DiracNFTs is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    address public firstWinnerAddress;
    address public secondWinnerAddress;
    address public thirdWinnerAddress;

    event TokenMint(uint256 tokenId, string uri);

    constructor(
        address initialOwner
    ) ERC721("Dirac NFTs", "DRC") Ownable(initialOwner) {}

    function safeMint(int256 placeId, string memory uri) public {
        uint256 tokenId = _nextTokenId++;

        if (placeId == 0) {
            require(msg.sender == firstWinnerAddress, "NOT AUTHORIZE");
            _safeMint(msg.sender, tokenId);
            _setTokenURI(tokenId, uri);
        } else if (placeId == 1) {
            require(msg.sender == secondWinnerAddress, "NOT AUTHORIZE");
            _safeMint(msg.sender, tokenId);
            _setTokenURI(tokenId, uri);
        } else if (placeId == 2) {
            require(msg.sender == thirdWinnerAddress, "NOT AUTHORIZE");
            _safeMint(msg.sender, tokenId);
            _setTokenURI(tokenId, uri);
        } else {
            _safeMint(msg.sender, tokenId);
            _setTokenURI(tokenId, uri);
        }
        emit TokenMint(tokenId, uri);
    }

    function mint(uint256 tokenId) public {
        _safeMint(msg.sender, tokenId);
    }

    function setTokenURI(string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _setTokenURI(tokenId, uri);

        emit TokenMint(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(
        address account,
        uint128 value
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function setFirstWinner(address winnerAddress) public onlyOwner {}

    function setSecondWinner(address winnerAddress) public onlyOwner {}

    function setThirdWinner(address winnerAddress) public onlyOwner {}
}
