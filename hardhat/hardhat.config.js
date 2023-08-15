require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18", // Note: The correct format is "0.8.18", not "0.8 * 0.18"

  networks: {
    mumbai: {
      url: process.env.RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },

  etherscan: {
    apiKey: process.env.API_KEY,
  },
};
