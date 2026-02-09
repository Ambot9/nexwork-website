<script setup lang="ts">
import { onMounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

const currentYear = new Date().getFullYear()

onMounted(() => {
  gsap.from('.footer-content', {
    scrollTrigger: {
      trigger: '.footer-content',
      start: 'top 90%',
      end: 'bottom 70%',
      toggleActions: 'play none none reverse'
    },
    y: 50,
    opacity: 0,
    duration: 1,
    ease: 'power3.out'
  })
})
</script>

<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-brand">
          <h3 class="brand-name">NEXWORK</h3>
          <p class="brand-tagline">Multi-repository feature management</p>
        </div>

        <div class="footer-links">
          <div class="link-group">
            <h4>Product</h4>
            <a href="#download">Download</a>
            <a href="https://github.com/Ambot9/nexwork-desktop" target="_blank">Documentation</a>
            <a href="https://github.com/Ambot9/nexwork-desktop/releases" target="_blank">Releases</a>
          </div>

          <div class="link-group">
            <h4>Community</h4>
            <a href="https://github.com/Ambot9/nexwork-desktop/issues" target="_blank">Issues</a>
            <a href="https://github.com/Ambot9/nexwork-desktop/discussions" target="_blank">Discussions</a>
            <a href="https://github.com/Ambot9/nexwork-desktop" target="_blank">GitHub</a>
          </div>

          <div class="link-group">
            <h4>Resources</h4>
            <a href="https://github.com/Ambot9/nexwork-desktop#readme" target="_blank">README</a>
            <a href="https://github.com/Ambot9/nexwork-desktop/blob/main/BUILD.md" target="_blank">Build Guide</a>
            <a href="https://github.com/Ambot9/nexwork-desktop/blob/main/SECURITY.md" target="_blank">Security</a>
          </div>
        </div>
      </div>

      <div class="footer-bottom">
        <p class="copyright">© {{ currentYear }} Ambot404. MIT License.</p>
        <div class="social-links">
          <a href="https://github.com/Ambot9/nexwork-desktop" target="_blank" class="social-link">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
              <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
            </svg>
          </a>
        </div>
      </div>
    </div>

    <div class="footer-gradient"></div>
  </footer>
</template>

<style scoped>
.footer {
  position: relative;
  padding: 4rem 0 2rem;
  background: #000000;
  border-top: 1px solid rgba(255, 255, 255, 0.08);
  z-index: 1;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.footer-content {
  display: grid;
  grid-template-columns: 1.5fr 2fr;
  gap: 4rem;
  margin-bottom: 3rem;
}

.footer-brand {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.brand-name {
  font-size: 1.5rem;
  font-weight: 700;
  letter-spacing: -0.02em;
  color: #ffffff;
}

.brand-tagline {
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.5);
  line-height: 1.6;
}

.footer-links {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2rem;
}

.link-group {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.link-group h4 {
  font-size: 0.875rem;
  font-weight: 600;
  margin-bottom: 0.25rem;
  color: #ffffff;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.link-group a {
  color: rgba(255, 255, 255, 0.6);
  text-decoration: none;
  font-size: 0.875rem;
  transition: color 0.3s ease;
}

.link-group a:hover {
  color: #ffffff;
}

.footer-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 2rem;
  border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.copyright {
  color: rgba(255, 255, 255, 0.4);
  font-size: 0.875rem;
}

.social-links {
  display: flex;
  gap: 1rem;
}

.social-link {
  color: rgba(255, 255, 255, 0.5);
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
}

.social-link:hover {
  color: #ffffff;
  border-color: rgba(255, 255, 255, 0.3);
  background: rgba(255, 255, 255, 0.05);
}

.footer-gradient {
  display: none;
}

@media (max-width: 768px) {
  .footer {
    padding: 3rem 0 2rem;
  }

  .footer-content {
    grid-template-columns: 1fr;
    gap: 2.5rem;
  }

  .footer-links {
    grid-template-columns: repeat(2, 1fr);
    gap: 2rem 1.5rem;
  }

  .footer-bottom {
    flex-direction: column;
    gap: 1.5rem;
    text-align: center;
  }
}
</style>
