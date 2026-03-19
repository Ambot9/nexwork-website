<script setup lang="ts">
import { onMounted, ref } from 'vue'
import type { ComponentPublicInstance } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import { FolderTree, GitBranchPlus, HeartPulse, Layers3, ShieldCheck, Sparkles } from 'lucide-vue-next'

gsap.registerPlugin(ScrollTrigger)

interface Capability {
  title: string
  description: string
  eyebrow: string
  tone: 'blue' | 'mint' | 'amber'
}

const capabilities: Capability[] = [
  {
    eyebrow: 'Actually useful',
    title: 'Feature-first orchestration',
    description:
      'Create one feature, attach the right repositories, and keep the working scope visible instead of juggling branches manually across tabs and terminals.',
    tone: 'blue',
  },
  {
    eyebrow: 'Hard problem',
    title: 'Dependency-aware project expansion',
    description:
      'If one project depends on another, Nexwork can add the missing repo before setup fails later. That matters more than another generic checklist card.',
    tone: 'mint',
  },
  {
    eyebrow: 'Where teams struggle',
    title: 'Scoped workspaces per Git account',
    description:
      'Separate client, internal, and personal repositories cleanly while keeping switching fast for developers who work across multiple organizations.',
    tone: 'amber',
  },
  {
    eyebrow: 'Operational signal',
    title: 'Workspace health and Git visibility',
    description:
      'See remote drift, missing worktrees, local-only branches, and repository issues before they become delivery friction.',
    tone: 'blue',
  },
  {
    eyebrow: 'Context continuity',
    title: 'Feature Memory that stores the important parts',
    description:
      'Keep requirement and implementation context durable without turning the app into another task board. Store what should be remembered, not noise.',
    tone: 'mint',
  },
  {
    eyebrow: 'Shipping flow',
    title: 'In-app updates and release awareness',
    description:
      'The desktop app can now detect fresh releases, download updates in the background, and prompt for restart when a new version is ready.',
    tone: 'amber',
  },
]

const sectionRef = ref<HTMLElement | null>(null)
const cardRefs = ref<HTMLElement[]>([])

onMounted(() => {
  gsap.from('.capabilities-heading', {
    scrollTrigger: {
      trigger: '.capabilities-heading',
      start: 'top 80%',
      toggleActions: 'play none none reverse',
    },
    y: 48,
    opacity: 0,
    duration: 0.9,
    ease: 'power3.out',
  })

  cardRefs.value.forEach((card, index) => {
    gsap.from(card, {
      scrollTrigger: {
        trigger: card,
        start: 'top 86%',
        toggleActions: 'play none none reverse',
      },
      y: 42,
      opacity: 0,
      duration: 0.7,
      delay: index * 0.06,
      ease: 'power3.out',
    })
  })
})

const setCardRef = (element: Element | ComponentPublicInstance | null) => {
  if (element instanceof HTMLElement && !cardRefs.value.includes(element)) {
    cardRefs.value.push(element)
  }
}

const iconMap = {
  blue: FolderTree,
  mint: HeartPulse,
  amber: GitBranchPlus,
}
</script>

<template>
  <section id="features" ref="sectionRef" class="capabilities">
    <div class="section-shell">
      <div class="capabilities-heading">
        <div class="heading-kicker">
          <Layers3 :size="16" />
          Only the features that change how the product actually feels
        </div>
        <h2>Not a laundry list. Just the capabilities that make Nexwork interesting.</h2>
        <p>
          We trimmed the generic “nice to have” grid and kept the parts that matter for multi-repository teams:
          dependency handling, workspace scoping, Git visibility, and durable feature context.
        </p>
      </div>

      <div class="capability-grid">
        <article
          v-for="capability in capabilities"
          :key="capability.title"
          :ref="setCardRef"
          class="capability-card"
          :class="`capability-card--${capability.tone}`"
        >
          <div class="capability-icon">
            <component :is="iconMap[capability.tone]" :size="20" />
          </div>
          <div class="capability-eyebrow">{{ capability.eyebrow }}</div>
          <h3>{{ capability.title }}</h3>
          <p>{{ capability.description }}</p>
        </article>
      </div>

      <div class="capability-note">
        <ShieldCheck :size="18" />
        <span>Nexwork is for the awkward real-world cases: cross-repo features, mixed account contexts, and handoff-sensitive implementation work.</span>
      </div>
    </div>
  </section>
</template>

<style scoped>
.capabilities {
  position: relative;
  padding: 32px 24px 92px;
  z-index: 1;
}

.section-shell {
  width: min(1240px, calc(100% - 16px));
  margin: 0 auto;
}

.capabilities-heading {
  max-width: 780px;
  margin-bottom: 32px;
}

.heading-kicker {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 14px;
  padding: 9px 14px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.62);
  border: 1px solid var(--line);
  color: var(--accent-strong);
  font-size: 0.82rem;
  font-weight: 700;
}

.capabilities-heading h2 {
  margin: 0 0 14px;
  font-size: clamp(2rem, 4vw, 3.8rem);
  line-height: 1.04;
  letter-spacing: -0.05em;
  color: var(--surface-dark);
}

.capabilities-heading p {
  margin: 0;
  max-width: 690px;
  font-size: 1.02rem;
  line-height: 1.8;
  color: var(--text-soft);
}

.capability-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 18px;
}

.capability-card {
  padding: 24px;
  border-radius: var(--radius-lg);
  background: var(--surface);
  border: 1px solid rgba(255, 255, 255, 0.8);
  box-shadow: var(--shadow-md);
  backdrop-filter: blur(18px);
}

.capability-card--blue .capability-icon {
  background: var(--accent-soft);
  color: var(--accent);
}

.capability-card--mint .capability-icon {
  background: var(--mint-soft);
  color: var(--mint);
}

.capability-card--amber .capability-icon {
  background: rgba(227, 138, 29, 0.14);
  color: var(--amber);
}

.capability-icon {
  width: 42px;
  height: 42px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 14px;
  margin-bottom: 16px;
}

.capability-eyebrow {
  margin-bottom: 8px;
  font-size: 0.76rem;
  font-weight: 800;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--text-soft);
}

.capability-card h3 {
  margin: 0 0 10px;
  font-size: 1.2rem;
  line-height: 1.22;
  color: var(--surface-dark);
}

.capability-card p {
  margin: 0;
  color: var(--text-soft);
  line-height: 1.72;
}

.capability-note {
  margin-top: 18px;
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 12px 16px;
  border-radius: 18px;
  background: rgba(13, 23, 38, 0.92);
  color: rgba(239, 245, 255, 0.86);
  box-shadow: var(--shadow-md);
}

@media (max-width: 980px) {
  .capability-grid {
    grid-template-columns: 1fr 1fr;
  }
}

@media (max-width: 640px) {
  .capabilities {
    padding-inline: 16px;
  }

  .capability-grid {
    grid-template-columns: 1fr;
  }

  .capability-note {
    align-items: flex-start;
  }
}
</style>
