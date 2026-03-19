<script setup lang="ts">
import { onMounted, ref } from 'vue'
import gsap from 'gsap'
import { ArrowRight, Github, Layers3, ShieldCheck, Sparkles } from 'lucide-vue-next'
import logoUrl from '@/assets/logo.svg'

const titleRef = ref<HTMLElement | null>(null)
const introRef = ref<HTMLElement | null>(null)
const actionsRef = ref<HTMLElement | null>(null)
const proofRef = ref<HTMLElement | null>(null)

onMounted(() => {
  const timeline = gsap.timeline({ defaults: { ease: 'power3.out' } })

  timeline
    .from('.site-shell', { y: -24, opacity: 0, duration: 0.8 })
    .from(titleRef.value, { y: 48, opacity: 0, duration: 0.9 }, '-=0.45')
    .from(introRef.value, { y: 28, opacity: 0, duration: 0.75 }, '-=0.48')
    .from(actionsRef.value, { y: 20, opacity: 0, duration: 0.65 }, '-=0.42')
    .from(proofRef.value, { y: 24, opacity: 0, duration: 0.65 }, '-=0.4')
})

const scrollToDownload = () => {
  document.getElementById('download')?.scrollIntoView({ behavior: 'smooth' })
}
</script>

<template>
  <section class="hero">
    <div class="site-shell">
      <a href="#" class="brand-lockup" aria-label="Nexwork home">
        <img :src="logoUrl" alt="Nexwork" class="brand-mark" />
        <div>
          <div class="brand-name">Nexwork</div>
          <div class="brand-subtitle">Multi-repo delivery workspace</div>
        </div>
      </a>

      <nav class="hero-nav">
        <a href="#features">Capabilities</a>
        <a href="#download">Download</a>
        <a href="https://github.com/Ambot9/nexwork-desktop" target="_blank" rel="noreferrer">GitHub</a>
      </nav>
    </div>

    <div class="hero-body">
      <div class="hero-copy">
        <div class="hero-pill">
          <Sparkles :size="14" />
          Built for teams juggling real client, internal, and multi-account work
        </div>

        <h1 ref="titleRef" class="hero-title">
          One desktop workspace for the feature work that usually spills across five repositories and three Git accounts.
        </h1>

        <div ref="introRef" class="hero-text">
          <p>
            Nexwork turns multi-repository feature delivery into a visible workflow: scoped workspaces, isolated feature
            branches, worktree setup, Git sync, and feature memory without the usual folder chaos.
          </p>
          <p>
            It is designed for the hard cases, not just the happy path: cross-repo features, account switching,
            dependency-aware project expansion, and handoff-friendly context.
          </p>
        </div>

        <div ref="actionsRef" class="hero-actions">
          <button class="cta-primary" @click="scrollToDownload">
            Download Nexwork
            <ArrowRight :size="18" />
          </button>
          <a
            href="https://github.com/Ambot9/nexwork-desktop"
            target="_blank"
            rel="noreferrer"
            class="cta-secondary"
          >
            <Github :size="18" />
            View source
          </a>
        </div>
      </div>

      <div ref="proofRef" class="hero-proof">
        <div class="proof-card proof-card-primary">
          <div class="proof-label">Interesting part</div>
          <h3>Feature orchestration instead of raw repository juggling</h3>
          <p>
            Create one feature, attach the right projects, branch from the correct base, and keep the whole scope visible
            in one place.
          </p>
        </div>

        <div class="proof-grid">
          <div class="proof-card">
            <div class="proof-icon">
              <Layers3 :size="18" />
            </div>
            <strong>Dependency-aware project selection</strong>
            <span>If one repo depends on another, Nexwork can add the required project before work starts.</span>
          </div>

          <div class="proof-card">
            <div class="proof-icon proof-icon-mint">
              <ShieldCheck :size="18" />
            </div>
            <strong>Scoped workspaces per account</strong>
            <span>Keep client, internal, and personal repositories separated without losing convenience.</span>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.hero {
  position: relative;
  padding: 24px 24px 64px;
  z-index: 1;
}

.site-shell,
.hero-body {
  width: min(1240px, calc(100% - 16px));
  margin: 0 auto;
}

.site-shell {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  padding: 18px 24px;
  border: 1px solid var(--line);
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.68);
  backdrop-filter: blur(16px);
  box-shadow: 0 12px 34px rgba(20, 46, 86, 0.08);
}

.brand-lockup {
  display: inline-flex;
  align-items: center;
  gap: 14px;
  text-decoration: none;
}

.brand-mark {
  width: 44px;
  height: 44px;
  display: block;
}

.brand-name {
  font-size: 1.08rem;
  font-weight: 700;
  color: var(--text);
}

.brand-subtitle {
  font-size: 0.84rem;
  color: var(--text-soft);
}

.hero-nav {
  display: flex;
  align-items: center;
  gap: 22px;
}

.hero-nav a {
  text-decoration: none;
  font-size: 0.94rem;
  font-weight: 600;
  color: var(--text-soft);
}

.hero-nav a:hover {
  color: var(--text);
}

.hero-body {
  display: grid;
  grid-template-columns: minmax(0, 1.25fr) minmax(320px, 0.9fr);
  gap: 36px;
  align-items: stretch;
  padding-top: 56px;
}

.hero-copy,
.hero-proof {
  min-width: 0;
}

.hero-pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.72);
  border: 1px solid rgba(19, 32, 51, 0.08);
  color: var(--accent-strong);
  font-size: 0.84rem;
  font-weight: 600;
}

.hero-title {
  margin: 22px 0 20px;
  max-width: 780px;
  font-size: clamp(2.9rem, 5.8vw, 5.8rem);
  line-height: 0.98;
  letter-spacing: -0.06em;
  font-weight: 700;
  color: var(--surface-dark);
}

.hero-text {
  display: grid;
  gap: 14px;
  max-width: 720px;
  font-size: 1.06rem;
  line-height: 1.75;
  color: var(--text-soft);
}

.hero-actions {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-top: 30px;
  flex-wrap: wrap;
}

.cta-primary,
.cta-secondary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  min-height: 54px;
  padding: 0 24px;
  border-radius: 18px;
  text-decoration: none;
  font-weight: 700;
  transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
}

.cta-primary {
  border: none;
  background: linear-gradient(135deg, var(--accent) 0%, #145ed4 100%);
  color: #fff;
  box-shadow: 0 18px 42px rgba(31, 122, 236, 0.3);
  cursor: pointer;
}

.cta-secondary {
  border: 1px solid var(--line-strong);
  background: rgba(255, 255, 255, 0.86);
  color: var(--text);
}

.cta-primary:hover,
.cta-secondary:hover {
  transform: translateY(-2px);
}

.hero-proof {
  display: grid;
  gap: 18px;
}

.proof-card {
  padding: 26px;
  border-radius: var(--radius-lg);
  background: var(--surface);
  border: 1px solid rgba(255, 255, 255, 0.65);
  box-shadow: var(--shadow-md);
  backdrop-filter: blur(18px);
}

.proof-card-primary {
  background: linear-gradient(160deg, rgba(13, 23, 38, 0.96), rgba(18, 39, 70, 0.92));
  color: #eff5ff;
}

.proof-card-primary h3 {
  margin: 10px 0 10px;
  font-size: 1.48rem;
  line-height: 1.18;
}

.proof-card-primary p,
.proof-card span {
  color: rgba(239, 245, 255, 0.72);
  line-height: 1.68;
}

.proof-label {
  display: inline-flex;
  padding: 7px 12px;
  border-radius: 999px;
  background: rgba(31, 122, 236, 0.18);
  color: #8ac0ff;
  font-size: 0.76rem;
  font-weight: 700;
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

.proof-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
}

.proof-card strong {
  display: block;
  margin: 14px 0 8px;
  font-size: 1.02rem;
  color: var(--text);
}

.proof-card span {
  display: block;
  color: var(--text-soft);
}

.proof-icon {
  width: 40px;
  height: 40px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 14px;
  background: var(--accent-soft);
  color: var(--accent);
}

.proof-icon-mint {
  background: var(--mint-soft);
  color: var(--mint);
}

@media (max-width: 980px) {
  .site-shell {
    border-radius: 28px;
    flex-direction: column;
    align-items: flex-start;
  }

  .hero-nav {
    flex-wrap: wrap;
    gap: 14px;
  }

  .hero-body {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 640px) {
  .hero {
    padding-inline: 16px;
  }

  .hero-title {
    font-size: 2.8rem;
  }

  .proof-grid {
    grid-template-columns: 1fr;
  }

  .cta-primary,
  .cta-secondary {
    width: 100%;
  }
}
</style>
