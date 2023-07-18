// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ClimateCoin is ERC20 {
    mapping(address => bool) public isAnAdmin;
    mapping(address => bool) public isAFarmer;
    mapping(address => uint256) public acreage;
    mapping(address => bool) public claims;
    mapping(address => uint256) public rewards;
    mapping(address => bool) public farmerWaitlist;

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

    function registerFarmer(address _farmer)
        public
    {
        farmerWaitlist[_farmer] = true;
    }

    function approveFarmer(address _farmer, uint256 _acerage)
        public
        onlyAdmins
    {
        farmerWaitlist[_farmer] = false;
        isAFarmer[_farmer] = true;
        acreage[_farmer] = _acerage;
        emit NewFarmer(_farmer);
    }

    function addAdmin(address _admin) public onlyAdmins {
        isAnAdmin[_admin] = true;
        emit NewAdminAdded(_admin);
    }
}
