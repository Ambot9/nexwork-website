<script setup lang="ts">
import { onMounted, ref, computed } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

interface Release {
  tag_name: string
  name: string
  body: string
  assets: Array<{
    name: string
    size: number
    browser_download_url: string
  }>
}

const release = ref<Release | null>(null)
const loading = ref(true)
const error = ref('')

const dmgAsset = computed(() => {
  if (!release.value) return null
  return release.value.assets.find(asset => asset.name.endsWith('.dmg'))
})

const zipAsset = computed(() => {
  if (!release.value) return null
  return release.value.assets.find(asset => asset.name.endsWith('.zip'))
})

const formatFileSize = (bytes: number): string => {
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB'
}

onMounted(async () => {
  // Fetch latest release from GitHub
  try {
    const response = await fetch('https://api.github.com/repos/Ambot9/nexwork-desktop/releases/latest')
    if (!response.ok) throw new Error('Failed to fetch release')
    release.value = await response.json()
  } catch (e) {
    error.value = 'Failed to load download links'
  } finally {
    loading.value = false
  }

  // Animations
  gsap.from('.download-title', {
    scrollTrigger: {
      trigger: '.download-title',
      start: 'top 80%',
      end: 'bottom 60%',
      toggleActions: 'play none none reverse'
    },
    y: 100,
    opacity: 0,
    duration: 1,
    ease: 'power3.out'
  })

  gsap.from('.download-card', {
    scrollTrigger: {
      trigger: '.download-card',
      start: 'top 80%',
      end: 'bottom 60%',
      toggleActions: 'play none none reverse'
    },
    scale: 0.8,
    opacity: 0,
    duration: 1,
    ease: 'back.out(1.7)'
  })

  gsap.from('.platform-info', {
    scrollTrigger: {
      trigger: '.platform-info',
      start: 'top 85%',
      end: 'bottom 60%',
      toggleActions: 'play none none reverse'
    },
    y: 50,
    opacity: 0,
    duration: 0.8,
    stagger: 0.2,
    ease: 'power3.out'
  })
})

const downloadFile = (url: string) => {
  window.open(url, '_blank')
}
</script>

<template>
  <section id="download" class="download">
    <div class="container">
      <h2 class="download-title">
        GET <span class="title-accent">NEXWORK</span>
      </h2>

      <div v-if="loading" class="loading">
        <div class="spinner"></div>
        <p>Loading download links...</p>
      </div>

      <div v-else-if="error" class="error">
        <p>{{ error }}</p>
        <a href="https://github.com/Ambot9/nexwork-desktop/releases" target="_blank" class="github-link">
          Visit GitHub Releases →
        </a>
      </div>

      <div v-else class="download-content">
        <div class="download-card">
          <div class="version-badge">{{ release?.tag_name }}</div>
          <h3 class="platform">macOS</h3>
          <p class="platform-desc">For Apple Silicon & Intel Macs</p>
          
          <div class="download-buttons">
            <button 
              v-if="dmgAsset"
              @click="downloadFile(dmgAsset.browser_download_url)"
              class="download-btn primary"
            >
              <span class="btn-icon">💾</span>
              <span class="btn-text">
                <span class="btn-label">Download DMG</span>
                <span class="btn-size">{{ formatFileSize(dmgAsset.size) }}</span>
              </span>
            </button>

            <button 
              v-if="zipAsset"
              @click="downloadFile(zipAsset.browser_download_url)"
              class="download-btn secondary"
            >
              <span class="btn-icon">📦</span>
              <span class="btn-text">
                <span class="btn-label">Download ZIP</span>
                <span class="btn-size">{{ formatFileSize(zipAsset.size) }}</span>
              </span>
            </button>
          </div>

          <div class="requirements">
            <p>macOS 10.15 (Catalina) or later</p>
          </div>
        </div>

        <div class="platform-grid">
          <div class="platform-info">
            <div class="info-icon">🍎</div>
            <h4>Universal Binary</h4>
            <p>Optimized for both Intel and Apple Silicon</p>
          </div>
          <div class="platform-info">
            <div class="info-icon">⚡</div>
            <h4>Instant Updates</h4>
            <p>Auto-update built-in for seamless upgrades</p>
          </div>
          <div class="platform-info">
            <div class="info-icon">🔒</div>
            <h4>Secure Download</h4>
            <p>Directly from GitHub releases</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.download {
  position: relative;
  padding: 8rem 0;
  background: #000000;
  z-index: 1;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.download-title {
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

.loading, .error {
  text-align: center;
  padding: 3rem;
}

.spinner {
  width: 50px;
  height: 50px;
  border: 3px solid rgba(255, 255, 255, 0.1);
  border-top-color: #ffffff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.github-link {
  color: #ffffff;
  text-decoration: none;
  border-bottom: 2px solid #ffffff;
  transition: opacity 0.3s ease;
}

.github-link:hover {
  opacity: 0.7;
}

.download-content {
  display: flex;
  flex-direction: column;
  gap: 4rem;
}

.download-card {
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.02) 100%);
  border: 2px solid rgba(255, 255, 255, 0.1);
  padding: 4rem 3rem;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.download-card::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.05) 0%, transparent 70%);
  animation: rotate 20s linear infinite;
}

@keyframes rotate {
  to { transform: rotate(360deg); }
}

.version-badge {
  position: absolute;
  top: 2rem;
  right: 2rem;
  padding: 0.5rem 1rem;
  background: #ffffff;
  color: #000000;
  font-weight: 700;
  font-size: 0.9rem;
  letter-spacing: 0.05em;
}

.platform {
  font-size: 3rem;
  font-weight: 900;
  margin-bottom: 0.5rem;
  position: relative;
  z-index: 1;
}

.platform-desc {
  font-size: 1.2rem;
  color: #cccccc;
  margin-bottom: 3rem;
  position: relative;
  z-index: 1;
}

.download-buttons {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  margin-bottom: 2rem;
  position: relative;
  z-index: 1;
  flex-wrap: wrap;
}

.download-btn {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.5rem 2.5rem;
  font-size: 1.1rem;
  font-weight: 700;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.download-btn.primary {
  background: #ffffff;
  color: #000000;
}

.download-btn.secondary {
  background: transparent;
  color: #ffffff;
  border: 2px solid #ffffff;
}

.download-btn::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  background: rgba(0, 0, 0, 0.1);
  border-radius: 50%;
  transform: translate(-50%, -50%);
  transition: width 0.5s ease, height 0.5s ease;
}

.download-btn:hover::before {
  width: 300px;
  height: 300px;
}

.download-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(255, 255, 255, 0.2);
}

.btn-icon {
  font-size: 2rem;
  position: relative;
  z-index: 1;
}

.btn-text {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  position: relative;
  z-index: 1;
}

.btn-label {
  font-size: 1.1rem;
}

.btn-size {
  font-size: 0.9rem;
  opacity: 0.7;
  font-weight: 400;
}

.requirements {
  font-size: 0.9rem;
  color: #888888;
  position: relative;
  z-index: 1;
}

.platform-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.platform-info {
  text-align: center;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid rgba(255, 255, 255, 0.05);
  transition: all 0.3s ease;
}

.platform-info:hover {
  background: rgba(255, 255, 255, 0.05);
  border-color: rgba(255, 255, 255, 0.1);
  transform: translateY(-5px);
}

.info-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  filter: grayscale(100%) brightness(200%);
}

.platform-info h4 {
  font-size: 1.3rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
}

.platform-info p {
  font-size: 1rem;
  color: #cccccc;
  line-height: 1.6;
}

@media (max-width: 768px) {
  .download {
    padding: 5rem 0;
  }

  .download-card {
    padding: 3rem 1.5rem;
  }

  .download-buttons {
    flex-direction: column;
  }

  .download-btn {
    width: 100%;
  }

  .platform-grid {
    grid-template-columns: 1fr;
  }
}
</style>
