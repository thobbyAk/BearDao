//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11; // Designate version of solidity

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // ERC20 template
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Wrapper.sol";

contract BearToken is ERC20, ERC20Permit, ERC20Votes, ERC20Wrapper {
    constructor(IERC20 wrappedToken)
        ERC20("Bare Token", "BTK")
        ERC20Permit("MyToken")
        ERC20Wrapper(wrappedToken)
    {
        // Token Name and Ticker
        _mint(msg.sender, 100000); // Mint 10000 tokens at beginning
    }

    function decimals()
        public
        view
        virtual
        override(ERC20, ERC20Wrapper)
        returns (uint8)
    {
        return 18;
    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        uint256 dayOfWeek = ((block.timestamp / 86400) + 4) % 7; // 0 = Sunday, 1 = Monday, etc

        require(dayOfWeek != 5); // Require that today is not friday
        super._burn(to, amount);
    }
}
