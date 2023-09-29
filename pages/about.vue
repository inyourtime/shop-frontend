<template>
  <h1>About page</h1>
  <div>Count: {{ count }}</div>
  <button @click="increment">Click</button>
</template>
<script setup lang="ts">
import { ref } from "vue"
const count = ref(0);
const increment = () => count.value++;
</script>