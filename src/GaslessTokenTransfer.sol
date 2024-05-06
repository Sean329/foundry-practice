// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GaslessTokenTransfer {
    function send(
        address _token,
        address _sender,
        address _receiver,
        uint _amount,
        uint _fee,
        uint _deadline,
        uint8 v, bytes32 r, bytes32 s
    ) external {
        IERC20Permit(_token).permit(
            _sender,
            address(this),
            _amount + _fee,
            _deadline,
            v,r,s
        );
        IERC20(_token).transferFrom(_sender, _receiver, _amount);
        IERC20(_token).transferFrom(_sender, msg.sender, _fee);
    }
}