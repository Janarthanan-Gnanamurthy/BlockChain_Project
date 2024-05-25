<template>
<div>
    <h2>Log Environmental Data</h2>
    <input v-model="shipmentId" placeholder="Shipment ID" />
    <input v-model="location" placeholder="Location" />
    <input v-model="temperature" placeholder="Temperature" />
    <input v-model="humidity" placeholder="Humidity" />
    <button @click="logEnvironmentalData">Log Data</button>
</div>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
data() {
    return {
    location: "",
    shipmentId: "",
    temperature: "",
    humidity: ""
    };
},
methods: {
    async logEnvironmentalData() {
    const accounts = await web3.eth.getAccounts();
    await contract.methods
        .updateShipmentStatus(this.shipmentId, this.location, this.temperature, this.humidity)
        .send({ from: accounts[0] });
    alert("Environmental Data Logged");
    }
}
};
</script>
  