// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ClimateCoin is ERC20 {
    mapping(address => bool) public isAnAdmin;
    mapping(address => bool) public isAFarmer;
    mapping(address => uint256) public acreage;
    mapping(address => bool) public claims;
    mapping(address => uint256) public rewards;

    event NewClaim(address indexed claimant);
    event ClaimApproved(address indexed farmer);
    event Rewarded(address indexed rewardee);
    event NewFarmer(address newFarmer);
    event NewAdminAdded(address sender);

    constructor(uint256 initialSupply) ERC20("ClimateToken", "CT") {
        _mint(msg.sender, initialSupply * decimals());
        isAnAdmin[msg.sender] = true;
    }

    modifier onlyAdmins() {
        require(isAnAdmin[msg.sender], "ClimateCoin:: Not an Admin");
        _;
    }

    function addClaim() public {
        require(isAFarmer[msg.sender], "ClimateCoin:: Not a Farmer");
        claims[msg.sender] = true;
        emit NewClaim(msg.sender);
    }

    function approveClaim(address _farmer) public onlyAdmins {
        require(claims[_farmer], "ClimateCoin:: No claims for Farmer");
        rewards[_farmer] = acreage[_farmer];
        emit ClaimApproved(_farmer);
    }

    function processRewards() public {
        require(rewards[msg.sender] > 0, "ClimateCoin:: No rewards for farmer");
        uint256 totalRewards = rewards[msg.sender] * decimals() * 4;
        rewards[msg.sender] = 0;
        claims[msg.sender] = false;
        _mint(msg.sender, totalRewards);
        emit Rewarded(msg.sender);
    }

    function registerFarmer(address[] memory _farmer, uint256[] memory _acreage)
        public
        onlyAdmins
    {
        for (uint256 i = 0; i < _farmer.length - 1; i++) {
            isAFarmer[_farmer[i]] = true;
            acreage[_farmer[i]] = _acreage[i];
            emit NewFarmer(_farmer[i]);
        }
    }

    function addAdmin(address[] memory _admin) public onlyAdmins {
        for (uint256 i = 0; i < _admin.length - 1; i++) {
            isAnAdmin[_admin[i]] = true;
            emit NewAdminAdded(_admin[i]);
        }
    }
}
