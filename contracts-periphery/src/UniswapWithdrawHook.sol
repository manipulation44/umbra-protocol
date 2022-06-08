// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import "src/interface/ISwapRouter.sol";

contract UniswapWithdrawHook is Ownable {
  using SafeERC20 for IERC20;

  ISwapRouter internal immutable swapRouter;

  constructor(ISwapRouter _swapRouter) {
    swapRouter = _swapRouter;
  }

  function tokensWithdrawn(
    uint256 _amount,
    address _stealthAddr,
    address _acceptor,
    address _tokenAddr,
    address _sponsor,
    uint256 _sponsorFee,
    bytes memory _data
  ) external{
    (address _recipient, bytes[] memory _multicallData) = abi.decode(_data, (address, bytes[]));
    swapRouter.multicall(_multicallData);

    if((IERC20(_tokenAddr).balanceOf(address(this)) > 0)) {
      IERC20(_tokenAddr).safeTransferFrom(address(this), _recipient, IERC20(_tokenAddr).balanceOf(address(this)));
    }
  }

  function approveToken(IERC20 _token) external onlyOwner {
    _token.safeApprove(address(swapRouter), type(uint256).max);
  }
}