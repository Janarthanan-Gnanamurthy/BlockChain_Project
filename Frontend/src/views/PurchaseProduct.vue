<template>
	<div>
		<h2>Purchase Product</h2>
		<input v-model="productId" placeholder="Product ID" />
		<button @click="purchaseProduct">Purchase</button>
	</div>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
	data() {
		return {
			productId: ""
		};
	},
	methods: {
		async purchaseProduct() {
			const accounts = await web3.eth.getAccounts();
			const product = await contract.methods.products(this.productId).call();
			await contract.methods
				.purchaseProduct(this.productId)
				.send({ from: accounts[0], value: product.price });
			alert("Product Purchased");
		}
	}
};
</script>
  