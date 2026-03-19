<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <div id="app">
    <RouterView />
  </div>
</template>

<style>
:root {
  --bg: #eef3fb;
  --surface: rgba(255, 255, 255, 0.82);
  --surface-strong: rgba(255, 255, 255, 0.95);
  --surface-dark: #0d1726;
  --text: #132033;
  --text-soft: #56657a;
  --line: rgba(19, 32, 51, 0.1);
  --line-strong: rgba(19, 32, 51, 0.16);
  --accent: #1f7aec;
  --accent-strong: #155fc2;
  --accent-soft: rgba(31, 122, 236, 0.12);
  --mint: #0fb58d;
  --mint-soft: rgba(15, 181, 141, 0.12);
  --amber: #e38a1d;
  --shadow-xl: 0 30px 80px rgba(20, 46, 86, 0.14);
  --shadow-md: 0 14px 34px rgba(20, 46, 86, 0.1);
  --radius-xl: 28px;
  --radius-lg: 20px;
}

* {
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}

body {
  margin: 0;
  min-height: 100vh;
  font-family: 'Sora', 'Avenir Next', 'Segoe UI', sans-serif;
  background:
    radial-gradient(circle at top left, rgba(31, 122, 236, 0.12), transparent 32%),
    radial-gradient(circle at top right, rgba(15, 181, 141, 0.12), transparent 26%),
    linear-gradient(180deg, #f4f7fc 0%, #eef3fb 52%, #e8eef8 100%);
  color: var(--text);
  overflow-x: hidden;
}

body::before {
  content: '';
  position: fixed;
  inset: 0;
  pointer-events: none;
  background-image:
    linear-gradient(rgba(255, 255, 255, 0.3) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255, 255, 255, 0.3) 1px, transparent 1px);
  background-size: 64px 64px;
  mask-image: radial-gradient(circle at center, black 22%, transparent 78%);
  opacity: 0.55;
}

#app {
  width: 100%;
  min-height: 100vh;
  position: relative;
}

a {
  color: inherit;
}

button,
input {
  font: inherit;
}

::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: rgba(13, 23, 38, 0.06);
}

::-webkit-scrollbar-thumb {
  background: rgba(31, 122, 236, 0.34);
  border-radius: 999px;
}

::-webkit-scrollbar-thumb:hover {
  background: rgba(31, 122, 236, 0.48);
}
</style>
