<template>
	<div>
		<h2>Register Buyer</h2>
		<input v-model="name" placeholder="Buyer Name" />
		<input v-model="address" placeholder="Buyer Address" />
		<button @click="registerBuyer">Register</button>
		<div v-for="buyer in buyers" :key="buyer.id">{{buyer.name}}</div>
	</div>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
	data() {
		return {
			name: "",
			address: "",
			buyers: null
		};
	},
	created(){
		this.getAllBuyers();
	},
	methods: {
		async registerBuyer() {
			const accounts = await web3.eth.getAccounts();
			await contract.methods
				.registerBuyer(this.address,this.name)
				.send({ from: accounts[0] });
			alert("Buyer Registered");
		},
		async getAllBuyers(){
			this.buyers = await contract.methods.getAllBuyers().call();
		}
	}
};
</script>
  