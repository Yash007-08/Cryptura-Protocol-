// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrypturaProtocolLabs {
    string public projectName = "Cryptura Protocol Labs";
    uint256 private data;
    address public owner;

    event DataStored(uint256 indexed newData);
    event DataIncremented(uint256 indexed newData);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // Function 1: Store a value
    function storeData(uint256 _data) external onlyOwner {
        data = _data;
        emit DataStored(_data);
    }

    // Function 2: Retrieve the stored value
    function retrieveData() external view returns (uint256) {
        return data;
    }

    // Function 3: Increment the stored value
    function incrementData(uint256 _value) external onlyOwner {
        data += _value;
        emit DataIncremented(data);
    }
}
