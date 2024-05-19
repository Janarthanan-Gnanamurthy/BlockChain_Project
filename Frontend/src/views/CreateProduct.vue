<template>
	<div>
		<h2>Create Product</h2>
		<input v-model="name" placeholder="Product Name" />
		<input v-model="manufactureDate" type="date" placeholder="Manufacture Date" />
		<input v-model="expiryDate" type="date" placeholder="Expiry Date" />
		<input v-model="price" type="number" placeholder="Price in Wei" />
		<button @click="createProduct">Create Product</button>
	</div>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
	data() {
		return {
			name: "",
			manufactureDate: "",
			expiryDate: "",
			price: 0
		};
	},
	methods: {
		async createProduct() {
			const accounts = await web3.eth.getAccounts();
			const manufactureTimestamp = new Date(this.manufactureDate).getTime() / 1000;
			const expiryTimestamp = new Date(this.expiryDate).getTime() / 1000;
			try {
				await contract.methods
					.createProduct(this.name, manufactureTimestamp, expiryTimestamp, this.price)
					.send({ from: accounts[0] });
				alert("Product Created");
			} catch (error) {
				console.error(error);
				alert("Error creating product");
			}
		}
	}
};
</script>
  