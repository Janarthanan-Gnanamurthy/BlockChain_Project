<template>
  <div class="container mx-auto p-8">
    <h2 class="text-2xl font-bold mb-4">Available Products</h2>
    <div v-if="!loading && products.length === 0" class="alert alert-warning">
      No products available.
    </div>
    <ul v-if="!loading && products.length > 0" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      <li v-for="product in products" :key="product.id" class="card bg-base-100 shadow-xl">
        <div class="card-body">
          <h3 class="card-title">{{ product.name }}</h3>
          <p><strong>ProductID:</strong> {{ product.id }}</p>
          <p><strong>Manufacture Date:</strong> {{ new Date(Number(product.manufactureDate) * 1000).toLocaleDateString() }}</p>
          <p><strong>Expiry Date:</strong> {{ new Date(Number(product.expiryDate) * 1000).toLocaleDateString() }}</p>
          <p><strong>Price:</strong> {{ product.price }} Rs</p>
          <p v-if="product.forSale" class="badge badge-success">For Sale</p>
          <div class="card-actions w-full">
            <button @click="buy(product.id)" class="btn btn-primary w-full my-3">BUY</button>
          </div>
        </div>
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
    },
    async buy(productId) {
      const accounts = await web3.eth.getAccounts();
      await contract.methods
        .createShipment(productId, accounts[0], "coimbatore", 33, 66)
        .send({ from: accounts[0] });
      alert("Order Placed successfully");
    }
  }
};
</script>