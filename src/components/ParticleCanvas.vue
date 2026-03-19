<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'

const canvas = ref<HTMLCanvasElement | null>(null)

interface Particle {
  x: number
  y: number
  vx: number
  vy: number
  size: number
}

let animationFrame = 0
let resizeHandler: (() => void) | null = null

onMounted(() => {
  if (!canvas.value) return

  const ctx = canvas.value.getContext('2d')
  if (!ctx) return

  const particles: Particle[] = []
  const particleCount = 42

  const resize = () => {
    if (!canvas.value) return
    canvas.value.width = window.innerWidth
    canvas.value.height = window.innerHeight
  }

  resize()

  for (let i = 0; i < particleCount; i++) {
    particles.push({
      x: Math.random() * canvas.value.width,
      y: Math.random() * canvas.value.height,
      vx: (Math.random() - 0.5) * 0.18,
      vy: (Math.random() - 0.5) * 0.18,
      size: Math.random() * 2.2 + 0.8,
    })
  }

  const animate = () => {
    if (!canvas.value) return

    ctx.clearRect(0, 0, canvas.value.width, canvas.value.height)

    particles.forEach((particle, index) => {
      particle.x += particle.vx
      particle.y += particle.vy

      if (particle.x < -20) particle.x = canvas.value!.width + 20
      if (particle.x > canvas.value!.width + 20) particle.x = -20
      if (particle.y < -20) particle.y = canvas.value!.height + 20
      if (particle.y > canvas.value!.height + 20) particle.y = -20

      ctx.fillStyle = 'rgba(31, 122, 236, 0.18)'
      ctx.beginPath()
      ctx.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2)
      ctx.fill()

      for (let otherIndex = index + 1; otherIndex < particles.length; otherIndex += 1) {
        const otherParticle = particles[otherIndex]
        if (!otherParticle) continue

        const dx = particle.x - otherParticle.x
        const dy = particle.y - otherParticle.y
        const distance = Math.sqrt(dx * dx + dy * dy)

        if (distance < 160) {
          ctx.strokeStyle = `rgba(15, 181, 141, ${0.08 * (1 - distance / 160)})`
          ctx.lineWidth = 0.8
          ctx.beginPath()
          ctx.moveTo(particle.x, particle.y)
          ctx.lineTo(otherParticle.x, otherParticle.y)
          ctx.stroke()
        }
      }
    })

    animationFrame = window.requestAnimationFrame(animate)
  }

  animate()

  resizeHandler = resize
  window.addEventListener('resize', resizeHandler)
})

onBeforeUnmount(() => {
  if (animationFrame) {
    window.cancelAnimationFrame(animationFrame)
  }

  if (resizeHandler) {
    window.removeEventListener('resize', resizeHandler)
  }
})
</script>

<template>
  <canvas ref="canvas" class="particle-canvas"></canvas>
</template>

<style scoped>
.particle-canvas {
  position: fixed;
  inset: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
  pointer-events: none;
  opacity: 0.9;
}
</style>
