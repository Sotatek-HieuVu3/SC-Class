//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HieuVuToken is ERC20, Ownable {
    address private _treasury;

    constructor() ERC20("HieuVuToken", "HVT") {
        _mint(msg.sender, 2000 * 10**18);
        _treasury = 0x1e97479C07B555fFDa970C1dC4EA9C397BB9a99f;
    }

    mapping(address => bool) blackListed;

    function mintToken(uint256 _amount) external onlyOwner {
        _mint(msg.sender, _amount);
    }

    function burnToken(uint256 _amount) external onlyOwner {
        _burn(msg.sender, _amount);
    }

    function _beforeTokenTransfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal override {
        super._beforeTokenTransfer(_from, _to, _amount);
        require(!blackListed[_from], "Blacklisted User");
    }

    function addToBlacklists(address _address) external onlyOwner {
        blackListed[_address] = true;
    }

    function removeFromBlacklists(address _address) external onlyOwner {
        blackListed[_address] = false;
    }

    function getTreasuryAddress() public view returns (address) {
        return _treasury;
    }

    function chargeFee(address _from, uint256 _amount) internal {
        _transfer(_from, getTreasuryAddress(), _amount);
    }
}
