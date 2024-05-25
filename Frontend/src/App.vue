<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div id="app">
    <nav>
      <router-link class="m-2 p-2 btn btn-primary" to="/register-manufacturer">Register Manufacturer</router-link>
      <router-link class="m-2 p-2 btn btn-primary" to="/create-product">Create Product</router-link>
      <router-link class="m-2 p-2 btn btn-primary " to="/register-buyer">Register Buyer</router-link>
      <router-link class="m-2 p-2 btn btn-primary" to="/log-environmental-data">Log Environmental Data</router-link>
      <router-link class="m-2 p-2 btn btn-primary" to="/list-product-for-sale">List Product</router-link>
      <router-link class="m-2 p-2 btn btn-primary" to="/orders">Orders</router-link>
    </nav>
    <RouterView />
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>
