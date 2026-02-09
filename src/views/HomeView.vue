<script setup lang="ts">
import { onMounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import HeroSection from '@/components/HeroSection.vue'
import FeaturesSection from '@/components/FeaturesSection.vue'
import DownloadSection from '@/components/DownloadSection.vue'
import FooterSection from '@/components/FooterSection.vue'
import ParticleCanvas from '@/components/ParticleCanvas.vue'

gsap.registerPlugin(ScrollTrigger)

onMounted(() => {
  // Smooth scroll animations
  gsap.to('body', {
    ease: 'power2.inOut',
    duration: 1
  })
})
</script>

<template>
  <div class="home">
    <ParticleCanvas />
    <HeroSection />
    <FeaturesSection />
    <DownloadSection />
    <FooterSection />
  </div>
</template>

<style scoped>
.home {
  position: relative;
  width: 100%;
  min-height: 100vh;
}
</style>
