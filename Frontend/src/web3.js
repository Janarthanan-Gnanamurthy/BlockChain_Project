import Web3 from "web3";
import ContractABI from "./MedicalSupplyChain.json"; // ABI from compiled smart contract

let web3;
let contract;
const contractAddress = "0x494C7AA85Ed4c39838A0073bd720848135F371bd"; // Replace with your contract address

if (window.ethereum) {
  web3 = new Web3(window.ethereum);
  window.ethereum.enable();
} else {
  console.log("No Ethereum provider found. Install MetaMask.");
}

contract = new web3.eth.Contract(ContractABI, contractAddress);

export { web3, contract };
