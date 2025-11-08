// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title Cryptura Protocol
 * @notice A decentralized protocol that enables users to tokenize digital assets,
 *         transfer ownership securely, and verify authenticity on-chain.
 */
contract Project {
    address public admin;
    uint256 public assetCount;

    struct DigitalAsset {
        uint256 id;
        address owner;
        string assetHash;
        string metadata;
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => DigitalAsset) public assets;

    event AssetRegistered(uint256 indexed id, address indexed owner, string assetHash, string metadata);
    event OwnershipTransferred(uint256 indexed id, address indexed from, address indexed to);
    event AssetVerified(uint256 indexed id, address indexed verifier);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyOwner(uint256 _id) {
        require(assets[_id].owner == msg.sender, "Not the asset owner");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /**
     * @notice Register a new digital asset on the blockchain
     * @param _assetHash Unique hash of the asset
     * @param _metadata Metadata or description of the asset
     */
    function registerAsset(string memory _assetHash, string memory _metadata) external {
        require(bytes(_assetHash).length > 0, "Asset hash required");
        require(bytes(_metadata).length > 0, "Metadata required");

        assetCount++;
        assets[assetCount] = DigitalAsset(assetCount, msg.sender, _assetHash, _metadata, block.timestamp, false);

        emit AssetRegistered(assetCount, msg.sender, _assetHash, _metadata);
    }

    /**
     * @notice Transfer ownership of an asset to another address
     * @param _id Asset ID
     * @param _newOwner Address of the new owner
     */
    function transferOwnership(uint256 _id, address _newOwner) external onlyOwner(_id) {
        require(_newOwner != address(0), "Invalid new owner");

        address oldOwner = assets[_id].owner;
        assets[_id].owner = _newOwner;

        emit OwnershipTransferred(_id, oldOwner, _newOwner);
    }

    /**
     * @notice Verify a digital asset (admin only)
     * @param _id Asset ID
     */
    function verifyAsset(uint256 _id) external onlyAdmin {
        require(_id > 0 && _id <= assetCount, "Invalid asset ID");
        require(!assets[_id].verified, "Asset already verified");

        assets[_id].verified = true;
        emit AssetVerified(_id, msg.sender);
    }

    /**
     * @notice View a registered asset?s details
     * @param _id Asset ID
     * @return DigitalAsset struct containing asset details
     */
    function getAsset(uint256 _id) external view returns (DigitalAsset memory) {
        require(_id > 0 && _id <= assetCount, "Invalid asset ID");
        return assets[_id];
    }
}
// 
End
// 
