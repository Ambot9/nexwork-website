# Deployment Guide

## Quick Start

The website is currently running at: http://localhost:5174/

## Deploy to GitHub Pages

### Option 1: GitHub Actions (Recommended)

1. **Create GitHub repository:**
```bash
git init
git add .
git commit -m "Initial commit: Nexwork landing page"
git branch -M main
git remote add origin https://github.com/Ambot9/nexwork-website.git
git push -u origin main
```

2. **Enable GitHub Pages:**
   - Go to repository Settings → Pages
   - Source: GitHub Actions
   - The workflow in `.github/workflows/deploy.yml` will automatically deploy on every push to main

3. **Your site will be live at:**
   `https://ambot9.github.io/nexwork-website/`

### Option 2: Manual Deployment

Run the deploy script:
```bash
./deploy.sh
```

This will build and push to the `gh-pages` branch.

## Deploy to Netlify

1. **Connect Repository:**
   - Go to https://app.netlify.com/
   - Click "New site from Git"
   - Select your GitHub repository

2. **Build Settings:**
   - Build command: `npm run build`
   - Publish directory: `dist`

3. **Deploy:**
   - Click "Deploy site"
   - Your site will be live with a random subdomain
   - You can add a custom domain later

## Deploy to Vercel

1. **Install Vercel CLI:**
```bash
npm i -g vercel
```

2. **Deploy:**
```bash
vercel
```

3. **Follow prompts:**
   - Link to existing project or create new
   - Set up production deployment

## Environment Variables

No environment variables are required. The website fetches download links directly from the GitHub API:

```typescript
https://api.github.com/repos/Ambot9/nexwork-desktop/releases/latest
```

## Custom Domain

### GitHub Pages
1. Go to Settings → Pages → Custom domain
2. Add your domain (e.g., nexwork.app)
3. Update DNS records with your domain provider:
   - Add A records pointing to GitHub Pages IPs
   - Or add CNAME record pointing to `ambot9.github.io`

### Netlify/Vercel
- Both platforms have built-in custom domain setup in their dashboards

## Performance Optimization

The build is already optimized with:
- Terser minification
- Console log removal in production
- Code splitting
- Asset optimization
- Tree shaking

## Monitoring

After deployment, you can monitor:
- GitHub Pages: Check Actions tab for deployment status
- Netlify: Built-in analytics in dashboard
- Vercel: Built-in analytics and performance insights

## Updating Content

To update download links or content:
1. Edit the relevant component files
2. Commit and push to main branch
3. GitHub Actions will automatically rebuild and deploy

## Troubleshooting

### Downloads Not Working
- Check GitHub API rate limits (60 requests/hour for unauthenticated)
- Verify the repository name in `DownloadSection.vue` is correct
- Ensure the release has DMG/ZIP assets

### Animations Not Smooth
- Ensure users have hardware acceleration enabled in their browser
- Check if requestAnimationFrame is supported (all modern browsers)

### Build Fails
```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

## Support

For deployment issues, contact the repository maintainer or open an issue on GitHub.
