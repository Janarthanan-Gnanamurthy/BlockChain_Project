<template>
	<div>
		<h2>Register Seller</h2>
		<input v-model="name" placeholder="Seller Name" />
		<input v-model="address" placeholder="Seller Address" />
		<button @click="registerSeller">Register</button>
	</div>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
	data() {
		return {
			name: "",
			address: ""
		};
	},
	methods: {
		async registerSeller() {
			const accounts = await web3.eth.getAccounts();
			await contract.methods
				.registerSeller(this.name, this.address)
				.send({ from: accounts[0] });
			alert("Seller Registered");
		}
	}
};
</script>
  