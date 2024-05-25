<template>
	<div class="p-6">
		<h2 class="text-2xl font-bold mb-4">Shipments by Buyer</h2>
		<!-- <input v-model="buyerAddress" placeholder="Enter Buyer Address" class="input input-bordered w-full max-w-xs mb-4" />
		<button @click="getShipments" class="btn btn-primary mb-4">Get Shipments</button> -->
		
		<div v-if="shipments.length">
			<h3 class="text-xl font-semibold mb-2">Shipment List</h3>
			<div class="overflow-x-auto">
				<table class="table w-full">
					<thead>
						<tr>
							<th>ID</th>
							<th>Product ID</th>
							<th>Product Name</th>
							<th>Seller</th>
							<th>Current Location</th>
							<th>Date</th>
							<th>Status</th>
							<th>View Log</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="shipment in shipments" :key="shipment.id">
							<td>{{ shipment.id }}</td>
							<td>{{ shipment.productId }}</td>
							<td>{{ shipment.productName}}</td>
							<td>{{ shipment.manufacturerUsername }}</td>
							<td>{{ shipment.statusUpdates.at(-1).location.toString() }}</td>
							<td>{{ new Date(Number(shipment.shipmentDate) * 1000).toLocaleString() }}</td>
							<td>{{ shipment.received ? 'Received' : 'In Transit' }}</td>
							<td><button class="btn btn-primary" @click="redirect(shipment.id)">View Log</button></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div v-else class="text-xl font-semibold" > Not shipments Available</div>
	</div>
</template>

<script>
import { contract, web3 } from "@/web3";

export default {
	data() {
		return {
			buyerAddress: "",
			shipments: [],
		};
	},
	created(){
		this.getShipments();
		console.log(this.shipments)
	},
	methods: {
		async getShipments() {
			try {
				const accounts = await web3.eth.getAccounts();
				const data = await contract.methods.getShipmentsByBuyer(accounts[0]).call();
				// this.shipments = data.map(shipment => ({
				// 	id: shipment.id.toString(),
				// 	productId: shipment.productId.toString(),
				// 	sender: shipment.sender,
				// 	receiver: shipment.receiver,
				// 	shipmentDate: shipment.shipmentDate.toString(),
				// 	received: shipment.received
				// }));
				this.shipments = data
				console.log(this.shipments);
			} catch (error) {
				console.error("Error fetching shipments:", error);
			}
		},
		async redirect(shipmentId){
			this.$router.push(`/environmental-data-display/${shipmentId}`)
		}
	}
};
</script>
  