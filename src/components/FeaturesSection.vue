<script setup lang="ts">
import { onMounted, ref } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

interface Feature {
  icon: string
  title: string
  description: string
}

const features: Feature[] = [
  {
    icon: '⚡',
    title: 'Lightning Fast',
    description: 'Built with Electron for native desktop performance and instant feature switching.'
  },
  {
    icon: '🎯',
    title: 'Multi-Repository',
    description: 'Manage features across multiple repositories with git worktrees seamlessly.'
  },
  {
    icon: '🎨',
    title: '6 Beautiful Themes',
    description: 'Choose from System, Light, Dark, Ember, Monokai, and One Dark Pro themes.'
  },
  {
    icon: '💻',
    title: 'Integrated Terminal',
    description: 'Built-in terminal with AI assistance for powerful command execution.'
  },
  {
    icon: '🔍',
    title: 'Diff Viewer',
    description: 'Three viewing modes: split, unified, and inline for code comparison.'
  },
  {
    icon: '🔒',
    title: 'Secure & Safe',
    description: 'Input validation, rate limiting, and sandboxing keep your work protected.'
  }
]

const sectionRef = ref<HTMLElement | null>(null)
const featureRefs = ref<HTMLElement[]>([])

onMounted(() => {
  // Animate section title
  gsap.from('.features-title', {
    scrollTrigger: {
      trigger: '.features-title',
      start: 'top 80%',
      end: 'bottom 60%',
      toggleActions: 'play none none reverse'
    },
    y: 100,
    opacity: 0,
    duration: 1,
    ease: 'power3.out'
  })

  // Animate feature cards
  featureRefs.value.forEach((el, index) => {
    gsap.from(el, {
      scrollTrigger: {
        trigger: el,
        start: 'top 85%',
        end: 'bottom 60%',
        toggleActions: 'play none none reverse'
      },
      y: 100,
      opacity: 0,
      duration: 0.8,
      delay: index * 0.1,
      ease: 'power3.out'
    })

    // Hover animation
    el.addEventListener('mouseenter', () => {
      gsap.to(el, {
        y: -10,
        scale: 1.05,
        duration: 0.3,
        ease: 'power2.out'
      })
    })

    el.addEventListener('mouseleave', () => {
      gsap.to(el, {
        y: 0,
        scale: 1,
        duration: 0.3,
        ease: 'power2.out'
      })
    })
  })
})

const setFeatureRef = (el: any) => {
  if (el) {
    featureRefs.value.push(el)
  }
}
</script>

<template>
  <section ref="sectionRef" class="features">
    <div class="container">
      <div class="section-header">
        <h2 class="section-title">
          Everything you need to<br><span class="gradient-text">manage features</span>
        </h2>
        <p class="section-subtitle">
          Built for developers who demand efficiency and elegance in their workflow.
        </p>
      </div>
      <div class="features-grid">
        <div
          v-for="(feature, index) in features"
          :key="index"
          :ref="setFeatureRef"
          class="feature-card"
        >
          <div class="feature-icon">{{ feature.icon }}</div>
          <h3 class="feature-title">{{ feature.title }}</h3>
          <p class="feature-description">{{ feature.description }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.features {
  position: relative;
  padding: 10rem 0;
  background: #000000;
  z-index: 1;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.section-header {
  text-align: center;
  margin-bottom: 6rem;
  max-width: 800px;
  margin-left: auto;
  margin-right: auto;
}

.section-title {
  font-size: clamp(2.5rem, 6vw, 4rem);
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

.section-subtitle {
  font-size: clamp(1rem, 2vw, 1.25rem);
  font-weight: 400;
  color: rgba(255, 255, 255, 0.6);
  line-height: 1.7;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 1.5rem;
}

.feature-card {
  position: relative;
  padding: 2.5rem 2rem;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
}

.feature-card:hover {
  background: rgba(255, 255, 255, 0.04);
  border-color: rgba(255, 255, 255, 0.15);
  transform: translateY(-4px);
}

.feature-icon {
  font-size: 2.5rem;
  margin-bottom: 1.5rem;
  opacity: 0.9;
}

.feature-title {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 0.75rem;
  color: #ffffff;
  letter-spacing: -0.01em;
}

.feature-description {
  font-size: 1rem;
  line-height: 1.7;
  color: rgba(255, 255, 255, 0.6);
  font-weight: 400;
}

@media (max-width: 768px) {
  .features {
    padding: 6rem 0;
  }

  .section-header {
    margin-bottom: 4rem;
  }

  .features-grid {
    grid-template-columns: 1fr;
    gap: 1rem;
  }

  .feature-card {
    padding: 2rem 1.5rem;
  }
}
</style>
