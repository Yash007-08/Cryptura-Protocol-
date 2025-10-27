async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const CrypturaProtocolLabs = await ethers.getContractFactory("CrypturaProtocolLabs");
    const contract = await CrypturaProtocolLabs.deploy();

    await contract.deployed();

    console.log("CrypturaProtocolLabs deployed to:", contract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
