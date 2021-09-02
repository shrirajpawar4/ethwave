// const { ethers } = require("ethers");

async function main() {
    const waveContractFactory = await ethers.getContractFactory("Portal");
    const waveContract = await waveContractFactory.deploy({value: ethers.utils.parseEther("0.1")});
    await waveContract.deployed();
    console.log("Waveportal address", waveContract.address);
}

main()
 .then(() => process.exit(0))
 .catch((error) => {
     console.log(error);
     process.exit(1)
 })