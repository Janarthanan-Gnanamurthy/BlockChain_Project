<template>
  <div class="container mx-auto p-8">
    <h2 class="text-2xl font-bold mb-4">Environmental Data for Shipment</h2>
    <div v-if="statuses.length" class="mt-8">
      <h3 class="text-xl font-bold mb-2">Status Updates</h3>
      <ul class="list-disc list-inside">
        <li v-for="(status, index) in statuses" :key="index" class="mb-2">
          <p>
            <strong>Location:</strong> {{ status.location }}, <strong>Temperature:</strong>
            {{ status.temperature }}°C, <strong>Humidity:</strong> {{ status.humidity }}%
          </p>
          <p>
            <strong>Timestamp:</strong>
            {{ new Date(Number(status.timestamp) * 1000).toLocaleString() }}
          </p>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { contract } from "@/web3";

export default {
  data() {
    return {
      shipmentId: this.$route.params.shipmentId,
      statuses: [],
    };
  },
  created(){
    this.getEnvironmentalData(this.shipmentId)
  },
  methods: {
    async getEnvironmentalData() {
      try {
        const data = await contract.methods.getShipmentStatusUpdates(Number(this.shipmentId)).call();
        this.statuses = data.map(status => ({
          location: status.location,
          temperature: Number(status.temperature),
          humidity: Number(status.humidity),
          timestamp: status.timestamp.toString(), // Convert BigInt to string
        }));
        console.log(this.statuses);
      } catch (error) {
        console.error("Error fetching environmental data:", error);
      }
    }
  }
};
</script>