<template>
	<main>
		<div v-for="shipment in shipments" :key="shipment.id">
			<p><strong>ID:</strong>{{ shipment.id }}</p>
			<p><strong>ProductID:</strong>{{ shipment.productId }}</p>
			<p><strong>Buyer:</strong>{{ shipment.sender }}</p>
			<p><strong>Seller:</strong>{{ shipment.receiver }}</p>
			<p><strong>ShipmentDate:</strong>{{ new Date(Number(shipment.shipmentDate) * 1000).toLocaleDateString() }}</p>
		</div>
	</main>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
	data(){
		return {
				shipments: null,
		}
	},
	created(){
		this.getShipments();
	},
	methods:{
		async getShipments(){
			this.shipments = await contract.methods.getAllShipments().call()
		}
	}
}
</script>


