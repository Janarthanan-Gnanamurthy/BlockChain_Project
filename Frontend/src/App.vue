<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div id="app">
    <nav>
      <router-link class="m-2 p-2" to="/register-manufacturer">Register Manufacturer</router-link>
      <router-link class="m-2 p-2" to="/create-product">Create Product</router-link>
      <router-link class="m-2 p-2" to="/create-shipment">Create Shipment</router-link>
      <router-link class="m-2 p-2" to="/log-environmental-data">Log Environmental Data</router-link>
      <router-link class="m-2 p-2" to="/environmental-data-display">Environmental Data Display</router-link>
      <router-link class="m-2 p-2" to="/list-product-for-sale">List Product</router-link>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>
