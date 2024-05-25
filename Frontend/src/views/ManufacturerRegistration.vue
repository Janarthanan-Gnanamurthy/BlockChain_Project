<template>
  <div>
    <h2>Register Manufacturer</h2>
    <input v-model="name" placeholder="Manufacturer Name" />
    <input v-model="address" placeholder="Manufacturer Address" />
    <button @click="registerManufacturer">Register</button>
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
    async registerManufacturer() {
      try {
        const accounts = await web3.eth.getAccounts();
        const result = await contract.methods
          .registerManufacturer(this.address, this.name)
          .send({ from: accounts[0] });
        alert("Manufacturer Registered", result);
      } catch (error) {
        // Handle the error
        console.error("Error registering manufacturer:", error);
        alert(`Error registering manufacturer: ${error.message}`);
      }
    }
  }
};
</script>
  