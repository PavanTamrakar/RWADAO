const hre = require("hardhat");

async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {

  // Deploy the DAO Contract
  const rwaContract = await hre.ethers.deployContract("RWA DAO", [
    RWAContract.target,
  ]);
  await rwaContract.waitForDeployment();
  console.log("RWA DAO deployed to:", rwaContract.target);

  // Sleep for 30 seconds to let Etherscan catch up with the deployments
  await sleep(30 * 1000);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});