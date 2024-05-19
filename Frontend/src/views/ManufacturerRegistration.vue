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
        const accounts = await web3.eth.getAccounts();
        await contract.methods
          .registerManufacturer(this.name, this.address)
          .send({ from: accounts[0] });
        alert("Manufacturer Registered");
      }
    }
  };
  </script>
  