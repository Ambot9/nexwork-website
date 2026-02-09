<script setup lang="ts">
import { onMounted, ref } from 'vue'
import gsap from 'gsap'

const heroRef = ref<HTMLElement | null>(null)
const titleRef = ref<HTMLElement | null>(null)
const subtitleRef = ref<HTMLElement | null>(null)
const ctaRef = ref<HTMLElement | null>(null)

onMounted(() => {
  // Hero entrance animation
  const tl = gsap.timeline({ defaults: { ease: 'power4.out' } })

  tl.from(titleRef.value, {
    y: 100,
    opacity: 0,
    duration: 1.2,
    delay: 0.3
  })
  .from(subtitleRef.value, {
    y: 50,
    opacity: 0,
    duration: 1,
  }, '-=0.6')
  .from(ctaRef.value, {
    y: 30,
    opacity: 0,
    duration: 0.8,
  }, '-=0.4')

  // Floating animation for title
  gsap.to(titleRef.value, {
    y: -10,
    duration: 2,
    repeat: -1,
    yoyo: true,
    ease: 'power1.inOut'
  })

  // Mouse move parallax effect - subtle movement
  if (heroRef.value) {
    heroRef.value.addEventListener('mousemove', (e) => {
      const { clientX, clientY } = e
      const { innerWidth, innerHeight } = window
      
      const xPos = (clientX / innerWidth - 0.5) * 20
      const yPos = (clientY / innerHeight - 0.5) * 20

      gsap.to(titleRef.value, {
        x: xPos,
        duration: 0.5,
        ease: 'power2.out'
      })

      gsap.to(subtitleRef.value, {
        x: xPos * 0.5,
        duration: 0.7,
        ease: 'power2.out'
      })
    })

    // Reset position when mouse leaves
    heroRef.value.addEventListener('mouseleave', () => {
      gsap.to(titleRef.value, {
        x: 0,
        duration: 0.8,
        ease: 'power2.out'
      })

      gsap.to(subtitleRef.value, {
        x: 0,
        duration: 0.8,
        ease: 'power2.out'
      })
    })
  }
})

const scrollToDownload = () => {
  const downloadSection = document.getElementById('download')
  if (downloadSection) {
    downloadSection.scrollIntoView({ behavior: 'smooth' })
  }
}
</script>

<template>
  <section ref="heroRef" class="hero">
    <div class="hero-content">
      <h1 ref="titleRef" class="hero-title">
        <span class="title-line">NEXWORK</span>
        <span class="title-line">DESKTOP</span>
      </h1>
      <p ref="subtitleRef" class="hero-subtitle">
        Multi-repository feature management.<br>
        Powered by git worktrees.
      </p>
      <button ref="ctaRef" @click="scrollToDownload" class="cta-button">
        DOWNLOAD NOW
        <span class="arrow">→</span>
      </button>
    </div>
    <div class="scroll-indicator">
      <div class="mouse">
        <div class="wheel"></div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.hero {
  position: relative;
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  z-index: 1;
}

.hero-content {
  text-align: center;
  z-index: 2;
  padding: 0 2rem;
  max-width: 1400px;
  width: 100%;
  margin: 0 auto;
}

.hero-title {
  font-size: clamp(4rem, 12vw, 10rem);
  font-weight: 900;
  letter-spacing: -0.05em;
  line-height: 0.9;
  margin-bottom: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.title-line {
  display: block;
  background: linear-gradient(135deg, #ffffff 0%, #888888 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-shadow: 0 10px 30px rgba(255, 255, 255, 0.3);
}

.hero-subtitle {
  font-size: clamp(1.2rem, 2.5vw, 1.8rem);
  font-weight: 300;
  color: #cccccc;
  margin-bottom: 3rem;
  line-height: 1.6;
}

.cta-button {
  padding: 1.5rem 3rem;
  font-size: 1.2rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  background-color: #ffffff;
  color: #000000;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
  display: inline-flex;
  align-items: center;
  gap: 1rem;
}

.cta-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(0, 0, 0, 0.3), transparent);
  transition: left 0.5s ease;
}

.cta-button:hover::before {
  left: 100%;
}

.cta-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 40px rgba(255, 255, 255, 0.3);
}

.cta-button:hover .arrow {
  transform: translateX(5px);
}

.arrow {
  transition: transform 0.3s ease;
  font-size: 1.5rem;
}

.scroll-indicator {
  position: absolute;
  bottom: 3rem;
  left: 50%;
  transform: translateX(-50%);
  z-index: 2;
}

.mouse {
  width: 30px;
  height: 50px;
  border: 2px solid #ffffff;
  border-radius: 15px;
  position: relative;
  animation: float 2s ease-in-out infinite;
}

.wheel {
  width: 6px;
  height: 10px;
  background: #ffffff;
  border-radius: 3px;
  position: absolute;
  top: 8px;
  left: 50%;
  transform: translateX(-50%);
  animation: scroll 2s ease-in-out infinite;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

@keyframes scroll {
  0% {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
  100% {
    opacity: 0;
    transform: translateX(-50%) translateY(20px);
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 3rem;
  }

  .hero-subtitle {
    font-size: 1.2rem;
  }

  .cta-button {
    padding: 1rem 2rem;
    font-size: 1rem;
  }
}
</style>
