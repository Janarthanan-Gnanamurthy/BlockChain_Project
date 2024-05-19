<script setup>
import TheWelcome from '../components/TheWelcome.vue'
</script>

<template>
  <main>
    <h1>Voting System</h1>

    <h2>Create Proposal</h2>
    <label for="proposalDescription">Proposal Description:</label>
    <input
      type="text"
      id="proposalDescription"
      placeholder="Proposal Description"
    /><br />
    <button onclick="createProposal()">Create Proposal</button>

    <h2>Vote for Proposal</h2>
    <label for="proposalId">Proposal ID:</label>
    <input type="text" id="proposalId" placeholder="Proposal ID" /><br />
    <button onclick="vote()">Vote</button>

    <h2>Get Proposal</h2>
    <label for="getProposalId">Proposal ID:</label>
    <input type="text" id="getProposalId" placeholder="Proposal ID" /><br />
    <button onclick="getProposal()">Get Proposal</button>

    <p id="proposalDetails"></p>

    <h2>All Proposals</h2>
    <ul id="proposalList"></ul>
  </main>
</template>


<script>
export default {
  data(){
    return {
      
    }
  }
}
</script>
