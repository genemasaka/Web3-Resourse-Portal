const main = async () => {
    // const [owner, randomPerson] = await hre.ethers.getSigners();
    const resourceContractFactory = await hre.ethers.getContractFactory("ResourcePortal");
    const resourceContract = await resourceContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
    await resourceContract.deployed();
    console.log("Contract addr: " , resourceContract.address);

    let resourceCount;
    resourceCount = await resourceContract.getTotalResources();
    console.log(resourceCount.toNumber());

    let resourceTxn = await resourceContract.resource("A message!");
    await resourceTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(resourceContract.address);
    console.log(
        hre.ethers.utils.formatEther(contractBalance)
    );

    let allResources = await resourceContract.getAllResources();
    console.log(allResources);

};

const runMain = async () => {
    try {
        await main();
        process.exit(0); //exit Node without error
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();