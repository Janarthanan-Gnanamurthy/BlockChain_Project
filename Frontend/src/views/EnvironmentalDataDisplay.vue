<template>
    <div>
        <h2>Environmental Data for Shipment</h2>
        <input v-model="shipmentId" placeholder="Shipment ID" />
        <button @click="getEnvironmentalData">Get Data</button>
        <div v-if="temperatureLog.length">
        <h3>Temperature Log</h3>
        <ul>
            <li v-for="(temp, index) in temperatureLog" :key="index">{{ temp }}°C</li>
        </ul>
        </div>
        <div v-if="humidityLog.length">
        <h3>Humidity Log</h3>
        <ul>
            <li v-for="(humidity, index) in humidityLog" :key="index">{{ humidity }}%</li>
        </ul>
        </div>
    </div>
</template>

<script>
import { contract } from "@/web3";

export default {
data() {
    return {
    shipmentId: "",
    temperatureLog: [],
    humidityLog: []
    };
},
methods: {
    async getEnvironmentalData() {
    const data = await contract.methods.getShipmentEnvironmentalData(this.shipmentId).call();
    this.temperatureLog = data.temperatureLog;
    this.humidityLog = data.humidityLog;
    }
}
};
</script>
  