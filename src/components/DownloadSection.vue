<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import { ArrowRight, Download, Github, Sparkles } from 'lucide-vue-next'

gsap.registerPlugin(ScrollTrigger)

interface Release {
  tag_name: string
  published_at?: string
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

const dmgAsset = computed(() => release.value?.assets.find((asset) => asset.name.endsWith('.dmg')) || null)
const zipAsset = computed(() => release.value?.assets.find((asset) => asset.name.endsWith('.zip')) || null)
const currentVersion = computed(() => release.value?.tag_name || 'v1.1.0-beta.2')
const publishedDate = computed(() => {
  if (!release.value?.published_at) return 'Latest release'
  return new Date(release.value.published_at).toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  })
})

const formatNumber = (count: number) => {
  if (count >= 1000000) return `${(count / 1000000).toFixed(1)}M`
  if (count >= 1000) return `${(count / 1000).toFixed(1)}K`
  return String(count)
}

const formatFileSize = (bytes: number) => `${(bytes / (1024 * 1024)).toFixed(1)} MB`

const downloadFile = (url: string) => {
  window.location.href = url
}

onMounted(async () => {
  try {
    const [latestResponse, allReleasesResponse, repoResponse] = await Promise.all([
      fetch('https://api.github.com/repos/Ambot9/nexwork-desktop/releases/latest'),
      fetch('https://api.github.com/repos/Ambot9/nexwork-desktop/releases'),
      fetch('https://api.github.com/repos/Ambot9/nexwork-desktop'),
    ])

    if (!latestResponse.ok) {
      throw new Error('Failed to fetch release')
    }

    release.value = await latestResponse.json()

    if (allReleasesResponse.ok) {
      const allReleases = await allReleasesResponse.json()
      totalDownloads.value = allReleases.reduce((sum: number, item: Release) => {
        return sum + item.assets.reduce((assetSum, asset) => assetSum + (asset.download_count || 0), 0)
      }, 0)
    }

    if (repoResponse.ok) {
      const repoData = await repoResponse.json()
      githubStars.value = repoData.stargazers_count || 0
    }
  } catch {
    error.value = 'Could not load the latest release metadata.'
  } finally {
    loading.value = false
  }

  gsap.from('.download-shell', {
    scrollTrigger: {
      trigger: '.download-shell',
      start: 'top 82%',
      toggleActions: 'play none none reverse',
    },
    y: 42,
    opacity: 0,
    duration: 0.9,
    ease: 'power3.out',
  })
})
</script>

<template>
  <section id="download" class="download">
    <div class="download-shell">
      <div class="download-copy">
        <div class="download-kicker">
          <Sparkles :size="15" />
          Latest release, direct from GitHub
        </div>

        <h2>Install the current Nexwork build, then let the desktop app handle future updates.</h2>

        <p>
          The website always points to the newest published desktop release. Once Nexwork is installed, the app can
          check for updates, download them in the background, and prompt for restart when the new build is ready.
        </p>

        <div v-if="!loading && !error" class="release-meta">
          <span>{{ currentVersion }}</span>
          <span>{{ publishedDate }}</span>
          <span v-if="githubStars > 0">{{ formatNumber(githubStars) }} GitHub stars</span>
          <span v-if="totalDownloads > 0">{{ formatNumber(totalDownloads) }} downloads</span>
        </div>

        <div class="download-points">
          <div class="download-point">
            <strong>For teams</strong>
            <span>Use one installable app for feature orchestration, Git visibility, and memory-aware delivery.</span>
          </div>
          <div class="download-point">
            <strong>For evaluators</strong>
            <span>Start with the latest macOS release and inspect the full source, release notes, and updater flow.</span>
          </div>
        </div>
      </div>

      <div class="download-panel">
        <div class="panel-header">
          <div>
            <div class="panel-label">Current desktop release</div>
            <h3>{{ currentVersion }}</h3>
          </div>
          <div class="panel-status">macOS build available</div>
        </div>

        <div v-if="loading" class="state-card">
          <div class="state-spinner"></div>
          <div>
            <strong>Loading latest release</strong>
            <span>Pulling release metadata from GitHub.</span>
          </div>
        </div>

        <div v-else-if="error" class="state-card state-card-error">
          <div>
            <strong>{{ error }}</strong>
            <span>You can still download directly from GitHub Releases.</span>
          </div>
          <a href="https://github.com/Ambot9/nexwork-desktop/releases" target="_blank" rel="noreferrer">
            Open releases
          </a>
        </div>

        <template v-else>
          <button
            v-if="dmgAsset"
            class="download-action download-action-primary"
            @click="downloadFile(dmgAsset.browser_download_url)"
          >
            <div>
              <strong>Download DMG</strong>
              <span>{{ formatFileSize(dmgAsset.size) }} • Recommended installer</span>
            </div>
            <ArrowRight :size="18" />
          </button>

          <button v-if="zipAsset" class="download-action" @click="downloadFile(zipAsset.browser_download_url)">
            <div>
              <strong>Download ZIP</strong>
              <span>{{ formatFileSize(zipAsset.size) }} • Portable archive</span>
            </div>
            <Download :size="18" />
          </button>

          <a
            href="https://github.com/Ambot9/nexwork-desktop/releases"
            target="_blank"
            rel="noreferrer"
            class="download-action"
          >
            <div>
              <strong>Read the release notes</strong>
              <span>Review packaged changes, assets, and distribution history.</span>
            </div>
            <ArrowRight :size="18" />
          </a>

          <a
            href="https://github.com/Ambot9/nexwork-desktop"
            target="_blank"
            rel="noreferrer"
            class="download-action download-action-link"
          >
            <div>
              <strong>Review the source</strong>
              <span>Browse the desktop codebase, docs, and issue tracker on GitHub.</span>
            </div>
            <Github :size="18" />
          </a>

          <div class="install-note">
            <strong>macOS note</strong>
            <p>If Gatekeeper warns after download, run the command below once and reopen the app.</p>
            <code>xattr -cr /Applications/Nexwork.app</code>
            <a
              href="https://github.com/Ambot9/nexwork-desktop/blob/main/INSTALLATION.md"
              target="_blank"
              rel="noreferrer"
            >
              Installation guide
            </a>
          </div>
        </template>
      </div>
    </div>
  </section>
</template>

<style scoped>
.download {
  position: relative;
  padding: 24px 24px 104px;
  z-index: 1;
}

.download-shell {
  width: min(1240px, calc(100% - 16px));
  margin: 0 auto;
  display: grid;
  grid-template-columns: minmax(0, 1.05fr) minmax(320px, 500px);
  gap: 28px;
  align-items: start;
}

.download-copy {
  padding: 28px 8px 0 0;
}

.download-kicker {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
  padding: 9px 14px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.68);
  border: 1px solid var(--line);
  color: var(--mint);
  font-size: 0.82rem;
  font-weight: 700;
}

.download-copy h2 {
  margin: 0 0 16px;
  max-width: 760px;
  font-size: clamp(2rem, 4.4vw, 4rem);
  line-height: 1.02;
  letter-spacing: -0.05em;
  color: var(--surface-dark);
}

.download-copy p {
  margin: 0;
  max-width: 700px;
  color: var(--text-soft);
  font-size: 1.03rem;
  line-height: 1.82;
}

.release-meta {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-top: 24px;
}

.release-meta span {
  display: inline-flex;
  padding: 9px 14px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.76);
  border: 1px solid var(--line);
  color: var(--text);
  font-size: 0.84rem;
  font-weight: 600;
}

.download-points {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 14px;
  margin-top: 28px;
}

.download-point {
  padding: 20px;
  border-radius: 22px;
  border: 1px solid rgba(255, 255, 255, 0.78);
  background: rgba(255, 255, 255, 0.7);
  box-shadow: var(--shadow-md);
}

.download-point strong {
  display: block;
  margin-bottom: 8px;
  font-size: 0.98rem;
  color: var(--surface-dark);
}

.download-point span {
  color: var(--text-soft);
  line-height: 1.65;
}

.download-panel {
  display: grid;
  gap: 14px;
  padding: 24px;
  border-radius: 30px;
  background:
    linear-gradient(150deg, rgba(255, 255, 255, 0.82), rgba(255, 255, 255, 0.98)),
    radial-gradient(circle at top right, rgba(31, 122, 236, 0.12), transparent 36%);
  border: 1px solid rgba(255, 255, 255, 0.88);
  box-shadow: var(--shadow-xl);
  backdrop-filter: blur(20px);
}

.panel-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 18px;
  margin-bottom: 4px;
}

.panel-label {
  margin-bottom: 8px;
  font-size: 0.78rem;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--text-soft);
  font-weight: 800;
}

.panel-header h3 {
  margin: 0;
  font-size: 1.8rem;
  letter-spacing: -0.04em;
  color: var(--surface-dark);
}

.panel-status {
  padding: 9px 14px;
  border-radius: 999px;
  background: var(--mint-soft);
  color: var(--mint);
  font-size: 0.8rem;
  font-weight: 700;
  white-space: nowrap;
}

.download-action,
.state-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  padding: 18px 18px;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.94);
  border: 1px solid var(--line);
  color: inherit;
  text-decoration: none;
}

.download-action {
  cursor: pointer;
  transition:
    transform 0.25s ease,
    box-shadow 0.25s ease,
    border-color 0.25s ease;
}

.download-action:hover {
  transform: translateY(-2px);
  box-shadow: 0 18px 30px rgba(20, 46, 86, 0.08);
  border-color: rgba(31, 122, 236, 0.18);
}

.download-action-primary {
  border: none;
  background: linear-gradient(135deg, var(--accent) 0%, #145ed4 100%);
  color: #fff;
  box-shadow: 0 18px 34px rgba(31, 122, 236, 0.24);
}

.download-action-link {
  background: rgba(241, 247, 255, 0.92);
}

.download-action strong,
.state-card strong {
  display: block;
  font-size: 1rem;
}

.download-action span,
.state-card span {
  display: block;
  margin-top: 5px;
  color: var(--text-soft);
  font-size: 0.92rem;
}

.download-action-primary span {
  color: rgba(255, 255, 255, 0.78);
}

.state-card {
  justify-content: flex-start;
}

.state-card-error {
  align-items: center;
}

.state-card-error a {
  flex-shrink: 0;
  color: var(--accent-strong);
  font-weight: 700;
  text-decoration: none;
}

.state-spinner {
  width: 18px;
  height: 18px;
  border-radius: 999px;
  border: 2px solid rgba(31, 122, 236, 0.18);
  border-top-color: var(--accent);
  animation: spin 0.9s linear infinite;
}

.install-note {
  display: grid;
  gap: 10px;
  padding: 18px;
  border-radius: 20px;
  background: rgba(13, 23, 38, 0.96);
  color: #e7eef9;
}

.install-note strong {
  font-size: 0.96rem;
}

.install-note p {
  margin: 0;
  color: rgba(231, 238, 249, 0.76);
  line-height: 1.62;
}

.install-note code {
  display: inline-flex;
  width: fit-content;
  padding: 12px 14px;
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.08);
  font-size: 0.92rem;
  overflow-wrap: anywhere;
}

.install-note a {
  width: fit-content;
  color: #87b8ff;
  font-weight: 700;
  text-decoration: none;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

@media (max-width: 1024px) {
  .download-shell {
    grid-template-columns: 1fr;
  }

  .download-copy {
    padding-right: 0;
  }
}

@media (max-width: 720px) {
  .download {
    padding: 18px 18px 84px;
  }

  .download-points {
    grid-template-columns: 1fr;
  }

  .panel-header,
  .download-action,
  .state-card {
    flex-direction: column;
    align-items: flex-start;
  }

  .panel-status {
    white-space: normal;
  }
}
</style>
