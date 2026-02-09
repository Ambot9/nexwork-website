<script setup lang="ts">
import { onMounted, ref } from 'vue'
import gsap from 'gsap'

const heroRef = ref<HTMLElement | null>(null)
const titleRef = ref<HTMLElement | null>(null)
const subtitleRef = ref<HTMLElement | null>(null)
const descriptionRef = ref<HTMLElement | null>(null)
const ctaRef = ref<HTMLElement | null>(null)

onMounted(() => {
  // Hero entrance animation - staggered and smooth
  const tl = gsap.timeline({ defaults: { ease: 'power3.out' } })

  tl.from(titleRef.value, {
    y: 60,
    opacity: 0,
    duration: 1,
    delay: 0.2
  })
  .from(subtitleRef.value, {
    y: 40,
    opacity: 0,
    duration: 0.9,
  }, '-=0.5')
  .from(descriptionRef.value, {
    y: 30,
    opacity: 0,
    duration: 0.8,
  }, '-=0.4')
  .from(ctaRef.value, {
    y: 20,
    opacity: 0,
    duration: 0.7,
  }, '-=0.3')
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
      <div class="badge">Developer Tools</div>
      <h1 ref="titleRef" class="hero-title">
        Multi-repository<br>feature management,<br><span class="gradient-text">simplified.</span>
      </h1>
      <p ref="subtitleRef" class="hero-subtitle">
        Nexwork Desktop streamlines your workflow with git worktrees.
      </p>
      <p ref="descriptionRef" class="hero-description">
        Manage features across multiple repositories with ease. Built for developers who value efficiency and elegance.
      </p>
      <div ref="ctaRef" class="cta-group">
        <button @click="scrollToDownload" class="cta-button primary">
          Download for macOS
        </button>
        <a href="https://github.com/Ambot9/nexwork-desktop" target="_blank" class="cta-button secondary">
          View on GitHub
        </a>
      </div>
    </div>
  </section>
</template>

<style scoped>
.hero {
  position: relative;
  width: 100%;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8rem 2rem;
  z-index: 1;
}

.hero-content {
  text-align: center;
  z-index: 2;
  max-width: 900px;
  width: 100%;
  margin: 0 auto;
}

.badge {
  display: inline-block;
  padding: 0.5rem 1.2rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 100px;
  font-size: 0.875rem;
  font-weight: 500;
  color: rgba(255, 255, 255, 0.7);
  letter-spacing: 0.05em;
  margin-bottom: 2.5rem;
  backdrop-filter: blur(10px);
}

.hero-title {
  font-size: clamp(2.5rem, 8vw, 4.5rem);
  font-weight: 700;
  letter-spacing: -0.03em;
  line-height: 1.15;
  margin-bottom: 1.5rem;
  color: #ffffff;
}

.gradient-text {
  background: linear-gradient(135deg, #ffffff 0%, #666666 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: clamp(1.25rem, 2.5vw, 1.5rem);
  font-weight: 400;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 1rem;
  line-height: 1.6;
}

.hero-description {
  font-size: clamp(1rem, 2vw, 1.125rem);
  font-weight: 300;
  color: rgba(255, 255, 255, 0.5);
  margin-bottom: 3rem;
  line-height: 1.8;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

.cta-group {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

.cta-button {
  padding: 1rem 2rem;
  font-size: 1rem;
  font-weight: 600;
  border-radius: 12px;
  border: none;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

.cta-button.primary {
  background: #ffffff;
  color: #000000;
  box-shadow: 0 4px 24px rgba(255, 255, 255, 0.15);
}

.cta-button.primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 32px rgba(255, 255, 255, 0.25);
  background: rgba(255, 255, 255, 0.95);
}

.cta-button.secondary {
  background: rgba(255, 255, 255, 0.05);
  color: #ffffff;
  border: 1px solid rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
}

.cta-button.secondary:hover {
  transform: translateY(-2px);
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.3);
}

.cta-button:active {
  transform: translateY(0);
}

@media (max-width: 768px) {
  .hero {
    padding: 6rem 1.5rem;
    min-height: 90vh;
  }

  .badge {
    font-size: 0.75rem;
    padding: 0.4rem 1rem;
  }

  .hero-title {
    font-size: 2.5rem;
    margin-bottom: 1.25rem;
  }

  .hero-subtitle {
    font-size: 1.125rem;
  }

  .hero-description {
    font-size: 1rem;
    margin-bottom: 2.5rem;
  }

  .cta-group {
    flex-direction: column;
    gap: 0.75rem;
  }

  .cta-button {
    width: 100%;
    padding: 0.875rem 1.5rem;
  }
}
</style>
