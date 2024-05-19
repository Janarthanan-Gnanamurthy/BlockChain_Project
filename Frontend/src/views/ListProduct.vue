<template>
  <div>
    <h2 class="text-2xl">Available Products</h2>
    <div v-if="loading">Loading products...</div>
    <div v-if="!loading && products.length === 0">No products available.</div>
    <ul v-if="!loading && products.length > 0">
      <li v-for="product in products" :key="product.id">
				<p><strong>ProductID: {{ product.id  }}</strong></p>
        <p><strong>Name:</strong> {{ product.name }}</p>
        <p><strong>Manufacture Date:</strong> {{ new Date(Number(product.manufactureDate) * 1000).toLocaleDateString() }}</p>
        <p><strong>Expiry Date:</strong> {{ new Date(Number(product.expiryDate) * 1000).toLocaleDateString() }}</p>
        <p><strong>Price:</strong> {{ product.price }} Rs</p>
        <p v-if="product.forSale"><strong>Status:</strong> For Sale</p>
				<button @click="buy(product.id)" class="btn btn-primary">BUY</button>
        <!-- <p v-else><strong>Status:</strong> Sold</p> -->
        <!-- <p v-if="product.buyer"><strong>Buyer:</strong> {{ product.buyer }}</p> -->
      </li>
    </ul>
  </div>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
  data() {
    return {
      products: null,
      loading: false,
    };
  },
  async created() {
    await this.fetchProducts();
  },
  methods: {
    async fetchProducts() {
      this.products = await contract.methods.getAllProducts().call();
      // const products = [];

      // for (let i = 1; i <= productCount; i++) {
      //   const product = await contract.methods.products(i).call();
      //   products.push(product);
      // }

      // this.products = products;
      // this.loading = false;
    },
		async buy(productId){
			const accounts = await web3.eth.getAccounts();
			await contract.methods
				.createShipment(productId, accounts[0])
				.send({ from: accounts[0] });
			alert("Shipment Created");
		}
  }
};
</script>
