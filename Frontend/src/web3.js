import Web3 from "web3";
import ContractABI from "../../truffle/build/contracts/MedicalSupplyChain.json"; // ABI from compiled smart contract

let web3;
let contract;
let contractAbi = ContractABI.abi
console.log(contractAbi)
const contractAddress = "0xbAFdaBD2879415279Db314EaF7C28cA1D5625059"; // Replace with your contract address

if (window.ethereum) {
  web3 = new Web3(window.ethereum);
  window.ethereum.enable();
} else {
  console.log("No Ethereum provider found. Install MetaMask.");
}

contract = new web3.eth.Contract(contractAbi, contractAddress);

export { web3, contract };
