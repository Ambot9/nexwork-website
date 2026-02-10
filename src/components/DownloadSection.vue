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
      <div class="section-header">
        <h2 class="section-title">
          Ready to <span class="gradient-text">get started?</span>
        </h2>
        <p class="section-subtitle">
          Download Nexwork Desktop and streamline your workflow today.
        </p>
      </div>

      <div v-if="loading" class="loading">
        <div class="spinner"></div>
        <p>Loading download...</p>
      </div>

      <div v-else-if="error" class="error">
        <p>{{ error }}</p>
        <a href="https://github.com/Ambot9/nexwork-desktop/releases" target="_blank" class="github-link">
          View on GitHub →
        </a>
      </div>

      <div v-else class="download-content">
        <div class="download-card">
          <div class="card-header">
            <div class="platform-icon">💻</div>
            <div>
              <h3 class="platform-name">macOS</h3>
              <p class="platform-desc">Universal Binary • {{ release?.tag_name }}</p>
            </div>
          </div>
          
          <div class="download-buttons">
            <button 
              v-if="dmgAsset"
              @click="downloadFile(dmgAsset.browser_download_url)"
              class="download-btn primary"
            >
              <span class="btn-label">Download DMG</span>
              <span class="btn-meta">{{ formatFileSize(dmgAsset.size) }} • Recommended</span>
            </button>

            <button 
              v-if="zipAsset"
              @click="downloadFile(zipAsset.browser_download_url)"
              class="download-btn secondary"
            >
              <span class="btn-label">Download ZIP</span>
              <span class="btn-meta">{{ formatFileSize(zipAsset.size) }} • Portable</span>
            </button>
          </div>

          <div class="requirements">
            <span class="req-icon">ℹ️</span>
            <span>macOS 10.15 (Catalina) or later</span>
          </div>

          <div class="install-help">
            <div class="help-header">
              <span class="help-icon">⚠️</span>
              <strong>First-time macOS users:</strong>
            </div>
            <p class="help-text">
              If you see a "damaged app" warning, open Terminal and run:
            </p>
            <code class="help-command">xattr -cr /Applications/Nexwork.app</code>
            <a 
              href="https://github.com/Ambot9/nexwork-desktop/blob/main/INSTALLATION.md" 
              target="_blank"
              class="help-link"
            >
              Full installation guide →
            </a>
          </div>
        </div>

        <div class="info-grid">
          <div class="info-item">
            <div class="info-icon">🍎</div>
            <div class="info-content">
              <h4>Universal Binary</h4>
              <p>Native support for Intel and Apple Silicon</p>
            </div>
          </div>
          <div class="info-item">
            <div class="info-icon">⚡</div>
            <div class="info-content">
              <h4>Auto Updates</h4>
              <p>Stay current with seamless updates</p>
            </div>
          </div>
          <div class="info-item">
            <div class="info-icon">🔒</div>
            <div class="info-content">
              <h4>Secure</h4>
              <p>Downloaded directly from GitHub</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.download {
  position: relative;
  padding: 10rem 0;
  background: #000000;
  z-index: 1;
}

.container {
  max-width: 900px;
  margin: 0 auto;
  padding: 0 2rem;
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
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

.loading, .error {
  text-align: center;
  padding: 3rem;
}

.spinner {
  width: 40px;
  height: 40px;
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
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  transition: color 0.3s ease;
}

.github-link:hover {
  color: #ffffff;
}

.download-content {
  display: flex;
  flex-direction: column;
  gap: 3rem;
}

.download-card {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 3rem;
  backdrop-filter: blur(10px);
}

.card-header {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  margin-bottom: 2.5rem;
}

.platform-icon {
  font-size: 3rem;
}

.platform-name {
  font-size: 1.5rem;
  font-weight: 600;
  color: #ffffff;
  margin-bottom: 0.25rem;
}

.platform-desc {
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.5);
}

.download-buttons {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 2rem;
}

.download-btn {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  padding: 1.25rem 1.5rem;
  border-radius: 12px;
  border: none;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  text-align: left;
}

.download-btn.primary {
  background: #ffffff;
  color: #000000;
}

.download-btn.primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(255, 255, 255, 0.2);
}

.download-btn.secondary {
  background: rgba(255, 255, 255, 0.05);
  color: #ffffff;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.download-btn.secondary:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.btn-label {
  font-size: 1rem;
  font-weight: 600;
  margin-bottom: 0.25rem;
}

.btn-meta {
  font-size: 0.875rem;
  opacity: 0.7;
  font-weight: 400;
}

.requirements {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.02);
  border-radius: 8px;
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.6);
}

.req-icon {
  font-size: 1rem;
}

.install-help {
  margin-top: 2rem;
  padding: 1.5rem;
  background: rgba(255, 200, 0, 0.05);
  border: 1px solid rgba(255, 200, 0, 0.2);
  border-radius: 12px;
}

.help-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  color: rgba(255, 255, 255, 0.9);
  font-size: 0.9rem;
}

.help-icon {
  font-size: 1.2rem;
}

.help-text {
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 0.75rem;
  line-height: 1.5;
}

.help-command {
  display: block;
  padding: 0.75rem 1rem;
  background: rgba(0, 0, 0, 0.5);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 6px;
  font-family: 'Monaco', 'Courier New', monospace;
  font-size: 0.875rem;
  color: #ffffff;
  margin-bottom: 1rem;
  overflow-x: auto;
}

.help-link {
  display: inline-flex;
  align-items: center;
  gap: 0.25rem;
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  transition: color 0.3s ease;
}

.help-link:hover {
  color: #ffffff;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.info-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  transition: all 0.3s ease;
}

.info-item:hover {
  background: rgba(255, 255, 255, 0.04);
  border-color: rgba(255, 255, 255, 0.12);
}

.info-icon {
  font-size: 2rem;
  flex-shrink: 0;
}

.info-content h4 {
  font-size: 1rem;
  font-weight: 600;
  color: #ffffff;
  margin-bottom: 0.25rem;
}

.info-content p {
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.6);
  line-height: 1.5;
}

@media (max-width: 768px) {
  .download {
    padding: 6rem 0;
  }

  .download-card {
    padding: 2rem 1.5rem;
  }

  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }
}
</style>
