# Nexwork Website

Professional landing page for Nexwork Desktop built with Vue 3, TypeScript, and GSAP.

## Features

- **Stunning Animations**: GSAP-powered smooth animations and transitions
- **Particle Background**: Interactive particle canvas with connection lines
- **Scroll Animations**: ScrollTrigger-based reveal animations
- **GitHub Integration**: Automatic download links from latest GitHub release
- **Black & White Theme**: Professional monochrome design
- **Fully Responsive**: Mobile, tablet, and desktop optimized
- **Performance Optimized**: Lightweight and fast loading

## Tech Stack

- Vue 3 (Composition API)
- TypeScript
- GSAP (GreenSock Animation Platform)
- ScrollTrigger
- Vite

## Development

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

## Animation Features

### Hero Section
- Entrance animations with staggered reveals
- Floating title animation
- Mouse parallax effect on hover
- Smooth scroll indicator

### Features Section
- Scroll-triggered card reveals
- Staggered animation delays
- Hover scale and lift effects
- Shine overlay on hover

### Download Section
- Scale-in animation
- Rotating gradient background
- Button ripple effects
- GitHub API integration for real-time downloads

### Particle Canvas
- 100 animated particles
- Connection lines between nearby particles
- Smooth movement with edge bouncing
- Optimized with requestAnimationFrame

## Project Structure

```
nexwork-website/
├── src/
│   ├── components/
│   │   ├── ParticleCanvas.vue     # Animated particle background
│   │   ├── HeroSection.vue        # Hero with parallax effect
│   │   ├── FeaturesSection.vue    # Feature cards with hover
│   │   ├── DownloadSection.vue    # GitHub API integration
│   │   └── FooterSection.vue      # Links and social
│   ├── views/
│   │   └── HomeView.vue           # Main landing page
│   └── App.vue                    # Root component
└── public/                        # Static assets
```

## License

MIT License - Copyright (c) 2026 Ambot404
