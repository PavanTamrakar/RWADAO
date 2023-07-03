const hre = require("hardhat");

async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  const rwaContract = await hre.ethers.deployContract("RWA DAO", [
    rwaContract.target,
  ]);
  await rwaContract.waitForDeployment();
  console.log("RWA DAO deployed to:", rwaContract.target);

  // Sleep for 30 seconds to let Etherscan catch up with the deployment
  await sleep(30 * 1000);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});