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
      <h2 class="features-title">
        <span class="title-accent">POWERFUL</span> FEATURES
      </h2>
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
          <div class="feature-shine"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.features {
  position: relative;
  padding: 8rem 0;
  background: linear-gradient(180deg, #000000 0%, #111111 100%);
  z-index: 1;
}

.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

.features-title {
  font-size: clamp(3rem, 8vw, 5rem);
  font-weight: 900;
  text-align: center;
  margin-bottom: 5rem;
  letter-spacing: -0.02em;
}

.title-accent {
  background: linear-gradient(135deg, #ffffff 0%, #666666 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.feature-card {
  position: relative;
  padding: 3rem 2rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  cursor: pointer;
  overflow: hidden;
  transition: all 0.3s ease;
}

.feature-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transition: left 0.5s ease;
}

.feature-card:hover::before {
  left: 100%;
}

.feature-card:hover {
  border-color: rgba(255, 255, 255, 0.3);
  background: rgba(255, 255, 255, 0.05);
}

.feature-icon {
  font-size: 4rem;
  margin-bottom: 1.5rem;
  filter: grayscale(100%) brightness(200%);
}

.feature-title {
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #ffffff;
}

.feature-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #cccccc;
}

.feature-shine {
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
  opacity: 0;
  transition: opacity 0.3s ease;
  pointer-events: none;
}

.feature-card:hover .feature-shine {
  opacity: 1;
}

@media (max-width: 768px) {
  .features {
    padding: 5rem 0;
  }

  .features-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }

  .feature-card {
    padding: 2rem 1.5rem;
  }
}
</style>
