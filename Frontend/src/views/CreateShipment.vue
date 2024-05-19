<template>
	<div>
		<h2>Create Shipment</h2>
		<input v-model="productId" placeholder="Product ID" />
		<input v-model="receiver" placeholder="Receiver Address" />
		<button @click="createShipment">Create Shipment</button>
	</div>
</template>
  
<script>
import { contract, web3 } from "@/web3";

export default {
	data() {
		return {
			productId: "",
			receiver: ""
		};
	},
	methods: {
		async createShipment() {
			const accounts = await web3.eth.getAccounts();
			await contract.methods
				.createShipment(this.productId, accounts[0])
				.send({ from: accounts[0] });
			alert("Shipment Created");
		}
	}
};
</script>
  