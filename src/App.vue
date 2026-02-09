<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <div id="app">
    <RouterView />
  </div>
</template>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

:root {
  --color-black: #000000;
  --color-white: #ffffff;
  --color-gray: #333333;
  --color-light-gray: #cccccc;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', sans-serif;
  background-color: var(--color-black);
  color: var(--color-white);
  overflow-x: hidden;
}

#app {
  width: 100%;
  min-height: 100vh;
}

::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: var(--color-black);
}

::-webkit-scrollbar-thumb {
  background: var(--color-gray);
  border-radius: 5px;
}

::-webkit-scrollbar-thumb:hover {
  background: var(--color-light-gray);
}
</style>
