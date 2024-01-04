// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {DiracNFTs} from "../src/ERC721.sol";

contract ERC721Script is Script {
    function run() external returns (DiracNFTs) {
        address initialOwner = 0x3d6560aD6cE98f562e8057DCD42BD96aA2E63cb3;
        vm.startBroadcast();
        DiracNFTs diracNFTs = new DiracNFTs(initialOwner);
        vm.stopBroadcast();

        return diracNFTs;
    }
}
