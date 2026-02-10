<script setup lang="ts">
import { onMounted, ref, computed } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import { Cloud, Github } from 'lucide-vue-next'

gsap.registerPlugin(ScrollTrigger)

interface Release {
  tag_name: string
  name: string
  body: string
  assets: Array<{
    name: string
    size: number
    browser_download_url: string
    download_count: number
  }>
}

const release = ref<Release | null>(null)
const loading = ref(true)
const error = ref('')
const totalDownloads = ref(0)
const githubStars = ref(0)

const dmgAsset = computed(() => {
  if (!release.value) return null
  return release.value.assets.find(asset => asset.name.endsWith('.dmg'))
})

const zipAsset = computed(() => {
  if (!release.value) return null
  return release.value.assets.find(asset => asset.name.endsWith('.zip'))
})

const currentVersion = computed(() => {
  if (!release.value) return 'v1.0.0'
  return release.value.tag_name
})

const formatFileSize = (bytes: number): string => {
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB'
}

const formatNumber = (count: number): string => {
  if (count >= 1000000) {
    return (count / 1000000).toFixed(1) + 'M'
  } else if (count >= 1000) {
    return (count / 1000).toFixed(1) + 'K'
  }
  return count.toString()
}

// Cast the duration values to number for gsap
const toNumber = (val: string | number): number => {
  return typeof val === 'string' ? parseFloat(val) : val
}

onMounted(async () => {
  try {
    // Fetch release, all releases for download count, and repo info
    const [latestResponse, allReleasesResponse, repoResponse] = await Promise.all([
      fetch('https://api.github.com/repos/Ambot9/nexwork-desktop/releases/latest'),
      fetch('https://api.github.com/repos/Ambot9/nexwork-desktop/releases'),
      fetch('https://api.github.com/repos/Ambot9/nexwork-desktop')
    ])
    
    if (!latestResponse.ok) throw new Error('Failed to fetch release')
    release.value = await latestResponse.json()
    
    // Calculate total downloads
    if (allReleasesResponse.ok) {
      const allReleases = await allReleasesResponse.json()
      totalDownloads.value = allReleases.reduce((total: number, rel: Release) => {
        return total + rel.assets.reduce((assetTotal: number, asset) => {
          return assetTotal + (asset.download_count || 0)
        }, 0)
      }, 0)
    }
    
    // Get GitHub stars
    if (repoResponse.ok) {
      const repoData = await repoResponse.json()
      githubStars.value = repoData.stargazers_count || 0
    }
  } catch (e) {
    error.value = 'Failed to load download links'
  } finally {
    loading.value = false
  }

  // Animations
  gsap.from('.download-badges', {
    scrollTrigger: {
      trigger: '.download-badges',
      start: 'top 85%',
      toggleActions: 'play none none reverse'
    },
    y: 30,
    opacity: 0,
    duration: 0.8,
    ease: 'power3.out'
  })

  gsap.from('.download-buttons-row', {
    scrollTrigger: {
      trigger: '.download-buttons-row',
      start: 'top 85%',
      toggleActions: 'play none none reverse'
    },
    y: 30,
    opacity: 0,
    duration: 0.8,
    delay: 0.2,
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
        <!-- Badges Row -->
        <div class="download-badges">
          <span class="badge badge-version">{{ currentVersion }}</span>
          <span class="badge badge-os">macOS 10.15+</span>
          <span class="badge badge-license">Free</span>
          <span v-if="githubStars > 0" class="badge badge-stars">
            <Github :size="14" />
            {{ formatNumber(githubStars) }} stars
          </span>
          <span v-if="totalDownloads > 0" class="badge badge-downloads">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
              <polyline points="7 10 12 15 17 10"/>
              <line x1="12" y1="15" x2="12" y2="3"/>
            </svg>
            {{ formatNumber(totalDownloads) }} downloads
          </span>
        </div>

        <!-- Download Buttons -->
        <div class="download-buttons-row">
          <button 
            v-if="dmgAsset"
            @click="downloadFile(dmgAsset.browser_download_url)"
            class="btn-download-primary"
          >
            <Cloud :size="20" />
            <span>Download for macOS</span>
          </button>

          <a 
            href="https://github.com/Ambot9/nexwork-desktop"
            target="_blank"
            class="btn-download-secondary"
          >
            <Github :size="20" />
            <span>View on GitHub</span>
          </a>
        </div>

        <!-- Alternative Downloads -->
        <div v-if="zipAsset" class="alternative-downloads">
          <button 
            @click="downloadFile(zipAsset.browser_download_url)"
            class="btn-download-zip"
          >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
              <polyline points="7 10 12 15 17 10"/>
              <line x1="12" y1="15" x2="12" y2="3"/>
            </svg>
            <span>Download ZIP</span>
            <span class="btn-meta">({{ formatFileSize(zipAsset.size) }})</span>
          </button>
        </div>

        <!-- Install Help -->
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
  max-width: 800px;
  margin: 0 auto;
  padding: 0 2rem;
}

.section-header {
  text-align: center;
  margin-bottom: 3rem;
}

.section-title {
  font-size: clamp(2.5rem, 6vw, 4rem);
  font-weight: 700;
  letter-spacing: -0.03em;
  line-height: 1.15;
  margin-bottom: 1rem;
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
  align-items: center;
  gap: 2rem;
}

/* Badges */
.download-badges {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 0.75rem;
}

.badge {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.5rem 1rem;
  border-radius: 9999px;
  font-size: 0.875rem;
  font-weight: 500;
  white-space: nowrap;
}

.badge-version {
  background: rgba(59, 130, 246, 0.15);
  color: #60a5fa;
  border: 1px solid rgba(59, 130, 246, 0.3);
}

.badge-os {
  background: rgba(34, 197, 94, 0.15);
  color: #4ade80;
  border: 1px solid rgba(34, 197, 94, 0.3);
}

.badge-license {
  background: rgba(168, 85, 247, 0.15);
  color: #c084fc;
  border: 1px solid rgba(168, 85, 247, 0.3);
}

.badge-stars {
  background: rgba(234, 179, 8, 0.15);
  color: #facc15;
  border: 1px solid rgba(234, 179, 8, 0.3);
}

.badge-downloads {
  background: rgba(249, 115, 22, 0.15);
  color: #fb923c;
  border: 1px solid rgba(249, 115, 22, 0.3);
}

/* Download Buttons */
.download-buttons-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 1rem;
}

.btn-download-primary {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  background: #2563eb;
  color: #ffffff;
  border: none;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  text-decoration: none;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);
}

.btn-download-primary:hover {
  background: #1d4ed8;
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
}

.btn-download-secondary {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.05);
  color: #ffffff;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  text-decoration: none;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-download-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

/* Alternative Downloads */
.alternative-downloads {
  display: flex;
  justify-content: center;
  width: 100%;
}

.btn-download-zip {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.875rem 1.5rem;
  background: rgba(59, 130, 246, 0.1);
  color: #60a5fa;
  border: 1px solid rgba(59, 130, 246, 0.3);
  border-radius: 10px;
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  text-decoration: none;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-download-zip:hover {
  background: rgba(59, 130, 246, 0.2);
  border-color: rgba(59, 130, 246, 0.5);
  transform: translateY(-2px);
}

.btn-download-zip .btn-meta {
  color: rgba(96, 165, 250, 0.7);
  font-size: 0.8rem;
  font-weight: 400;
}

/* Install Help */
.install-help {
  width: 100%;
  max-width: 600px;
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

@media (max-width: 768px) {
  .download {
    padding: 6rem 0;
  }

  .download-badges {
    gap: 0.5rem;
  }

  .badge {
    padding: 0.4rem 0.75rem;
    font-size: 0.8rem;
  }

  .download-buttons-row {
    flex-direction: column;
    width: 100%;
  }

  .btn-download-primary,
  .btn-download-secondary {
    width: 100%;
    justify-content: center;
  }
}
</style>
