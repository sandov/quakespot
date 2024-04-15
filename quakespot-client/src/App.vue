<template>
  <div>
    <h1>QuakeSpot</h1>
    <Features/>  
    <hr>
    <Comments />
  </div>
</template>

<script setup>
  import Features from './components/Features.vue'
  import Comments from './components/Comments.vue'
</script>


<style scoped>

h1{
  margin-bottom: 1em;
  position: relative;
  top: 0;
  color: #ddeeff;
  background-color: #112233;
  padding: .5em;
}

</style>
