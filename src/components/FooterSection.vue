<script setup lang="ts">
import { onMounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import { ArrowRight, Github } from 'lucide-vue-next'
import logoUrl from '@/assets/logo.svg'

gsap.registerPlugin(ScrollTrigger)

const currentYear = new Date().getFullYear()

onMounted(() => {
  gsap.from('.footer-shell', {
    scrollTrigger: {
      trigger: '.footer-shell',
      start: 'top 88%',
      toggleActions: 'play none none reverse',
    },
    y: 36,
    opacity: 0,
    duration: 0.85,
    ease: 'power3.out',
  })
})
</script>

<template>
  <footer class="footer">
    <div class="footer-shell">
      <div class="footer-card">
        <div class="footer-top">
          <div class="footer-brand">
            <div class="footer-lockup">
              <img :src="logoUrl" alt="Nexwork" class="footer-logo" />
              <div>
                <div class="footer-name">Nexwork</div>
                <div class="footer-tagline">Feature-first multi-repo delivery for teams that work in the messy real world.</div>
              </div>
            </div>

            <p class="footer-copy">
              Built for developers who are tired of managing one feature across several repositories, drifting branches,
              mixed Git accounts, and missing context.
            </p>

            <a href="#download" class="footer-cta">
              Download the latest desktop build
              <ArrowRight :size="17" />
            </a>
          </div>

          <div class="footer-links">
            <div class="link-group">
              <h4>Product</h4>
              <a href="#features">Capabilities</a>
              <a href="#download">Download</a>
              <a href="https://github.com/Ambot9/nexwork-desktop/releases" target="_blank" rel="noreferrer">Releases</a>
            </div>

            <div class="link-group">
              <h4>Resources</h4>
              <a href="https://github.com/Ambot9/nexwork-desktop#readme" target="_blank" rel="noreferrer">README</a>
              <a href="https://github.com/Ambot9/nexwork-desktop/blob/main/INSTALLATION.md" target="_blank" rel="noreferrer">Installation</a>
              <a href="https://github.com/Ambot9/nexwork-desktop/issues" target="_blank" rel="noreferrer">Issues</a>
            </div>

            <div class="link-group">
              <h4>Source</h4>
              <a href="https://github.com/Ambot9/nexwork-desktop" target="_blank" rel="noreferrer">Desktop repository</a>
              <a href="https://github.com/Ambot9/nexwork-website" target="_blank" rel="noreferrer">Website repository</a>
              <a href="https://github.com/Ambot9" target="_blank" rel="noreferrer">GitHub profile</a>
            </div>
          </div>
        </div>

        <div class="footer-bottom">
          <p>© {{ currentYear }} Nexwork. Built by Ambot9.</p>
          <a href="https://github.com/Ambot9/nexwork-desktop" target="_blank" rel="noreferrer" class="github-link">
            <Github :size="17" />
            View on GitHub
          </a>
        </div>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.footer {
  position: relative;
  padding: 0 24px 32px;
  z-index: 1;
}

.footer-shell {
  width: min(1240px, calc(100% - 16px));
  margin: 0 auto;
}

.footer-card {
  position: relative;
  overflow: hidden;
  padding: 32px;
  border-radius: 30px;
  background:
    radial-gradient(circle at top left, rgba(31, 122, 236, 0.18), transparent 30%),
    radial-gradient(circle at bottom right, rgba(15, 181, 141, 0.14), transparent 32%),
    linear-gradient(165deg, #0f1728 0%, #101b30 58%, #0b1322 100%);
  border: 1px solid rgba(148, 179, 231, 0.14);
  box-shadow: 0 34px 70px rgba(9, 16, 29, 0.22);
}

.footer-top {
  display: grid;
  grid-template-columns: minmax(0, 1.15fr) minmax(320px, 0.95fr);
  gap: 28px;
}

.footer-lockup {
  display: inline-flex;
  align-items: center;
  gap: 14px;
}

.footer-logo {
  width: 48px;
  height: 48px;
}

.footer-name {
  font-size: 1.18rem;
  font-weight: 700;
  color: #f7fbff;
}

.footer-tagline {
  margin-top: 4px;
  color: rgba(224, 234, 249, 0.68);
  line-height: 1.5;
}

.footer-copy {
  margin: 20px 0 24px;
  max-width: 560px;
  color: rgba(224, 234, 249, 0.78);
  line-height: 1.82;
}

.footer-cta {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  min-height: 50px;
  padding: 0 20px;
  border-radius: 16px;
  background: linear-gradient(135deg, var(--accent) 0%, #145ed4 100%);
  color: #fff;
  text-decoration: none;
  font-weight: 700;
  box-shadow: 0 18px 36px rgba(31, 122, 236, 0.22);
}

.footer-links {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 18px;
}

.link-group {
  padding: 18px;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
}

.link-group h4 {
  margin: 0 0 12px;
  color: #f7fbff;
  font-size: 0.88rem;
  letter-spacing: 0.06em;
  text-transform: uppercase;
}

.link-group a {
  display: block;
  margin-bottom: 10px;
  color: rgba(224, 234, 249, 0.72);
  text-decoration: none;
  line-height: 1.5;
}

.link-group a:last-child {
  margin-bottom: 0;
}

.link-group a:hover,
.github-link:hover {
  color: #ffffff;
}

.footer-bottom {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  margin-top: 28px;
  padding-top: 22px;
  border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.footer-bottom p {
  margin: 0;
  color: rgba(224, 234, 249, 0.58);
}

.github-link {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  color: rgba(224, 234, 249, 0.76);
  text-decoration: none;
  font-weight: 700;
}

@media (max-width: 1024px) {
  .footer-top {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .footer {
    padding: 0 18px 24px;
  }

  .footer-card {
    padding: 24px;
  }

  .footer-links {
    grid-template-columns: 1fr;
  }

  .footer-bottom {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>
