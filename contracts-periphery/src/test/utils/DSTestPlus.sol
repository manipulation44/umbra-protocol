// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/stdlib.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "solmate/test/utils/mocks/MockERC20.sol";

contract DSTestPlus is DSTest, stdCheats {
  Vm vm = Vm(HEVM_ADDRESS);
  StdStorage stdstore;
  using stdStorage for StdStorage;

  function setToll(address umbraAddr, uint256 newToll) public {
    stdstore.target(address(umbraAddr)).sig("toll()").checked_write(newToll);
  }
}