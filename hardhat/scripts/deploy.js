const hre = require("hardhat");

async function main() {
  try {
    const votingContract = await hre.ethers.getContractFactory("Voting");
    const deployedVotingContract = await votingContract.deploy();

    const contractAddress = deployedVotingContract.target;
    console.log("Contract Address deployed:", contractAddress);
  } catch (error) {
    console.error("Deployment error:", error);
  }
}

main().catch((error) => {
  console.error("Script error:", error);
  process.exitCode = 1;
});

//Contract Address deployed: 0x18A805040ECE1a6877cE576d6955d1c59db56e77
//https://mumbai.polygonscan.com/address/0x18A805040ECE1a6877cE576d6955d1c59db56e77#code
