import * as dotenv from 'dotenv'
import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'

dotenv.config()

const config: HardhatUserConfig = {
  solidity: '0.8.9',
  networks: {
    mumbai: {
      url: 'https://rpc-mumbai.maticvigil.com',
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
    matic: {
      url: 'https://rpc.ankr.com/polygon',
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
    zkevm: {
      url: 'https://zkevm-rpc.com',
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
    zkevmtestnet: {
      url: 'https://rpc.public.zkevm-test.net',
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.POLYSCAN_API_KEY ?? '',
      polygon: process.env.POLYSCAN_API_KEY ?? '',
      zkevm: process.env.ZKEVM_POLYSCAN_API_KEY ?? '',
      zkevmtestnet: process.env.ZKEVM_POLYSCAN_API_KEY ?? '',
    },
    customChains: [
      {
        network: 'zkevm',
        chainId: 1101,
        urls: {
          apiURL: 'https://api-zkevm.polygonscan.com/api',
          browserURL: 'https://zkevm.polygonscan.com',
        },
      },
      {
        network: 'zkevmtestnet',
        chainId: 1442,
        urls: {
          apiURL: 'https://api-testnet-zkevm.polygonscan.com/api',
          browserURL: 'https://testnet-zkevm.polygonscan.com',
        },
      },
    ],
  },
}

export default config
