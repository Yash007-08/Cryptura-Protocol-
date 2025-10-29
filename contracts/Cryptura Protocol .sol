Function 1: Store a value
    function storeData(uint256 _data) external onlyOwner {
        data = _data;
        emit DataStored(_data);
    }

    Function 3: Increment the stored value
    function incrementData(uint256 _value) external onlyOwner {
        data += _value;
        emit DataIncremented(data);
    }
}
// 
update
// 
