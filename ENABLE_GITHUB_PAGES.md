# 🚀 Enable GitHub Pages - Quick Guide

## The Issue

The website builds successfully but deployment fails because **GitHub Pages is not enabled** for the repository.

## Solution (2 Minutes)

### Step 1: Go to Repository Settings

Visit: **https://github.com/Ambot9/nexwork-website/settings/pages**

Or manually:
1. Go to https://github.com/Ambot9/nexwork-website
2. Click **Settings** tab (top right)
3. Click **Pages** in left sidebar

### Step 2: Enable GitHub Pages

Configure these settings:

**Source:**
- Select: **GitHub Actions** (NOT "Deploy from a branch")

That's it! No other configuration needed.

### Step 3: Trigger Deployment

The GitHub Actions workflow will automatically deploy on the next push.

To deploy immediately:
1. Go to **Actions** tab
2. Click **"Deploy to GitHub Pages"** workflow
3. Click **"Run workflow"** button (right side)
4. Click green **"Run workflow"** button

### Step 4: Wait for Deployment

The workflow takes about 30-60 seconds:
1. **Build job**: Installs dependencies, builds the site
2. **Deploy job**: Deploys to GitHub Pages

Watch progress at: https://github.com/Ambot9/nexwork-website/actions

### Step 5: Visit Your Live Site!

Once deployed (green checkmark), your site will be live at:

**https://ambot9.github.io/nexwork-website/**

## Why This Was Required

GitHub Pages must be explicitly enabled with the correct source:
- ❌ Default: Disabled
- ❌ Deploy from branch: Wrong (old method)
- ✅ GitHub Actions: Correct (modern method)

Our workflow file (`.github/workflows/deploy.yml`) requires the "GitHub Actions" source to work.

## Troubleshooting

### "Not Found" Error Persists
- Make sure you selected **"GitHub Actions"** as source (not branch)
- Save the settings
- Trigger workflow again

### Build Fails
- Check Actions tab for error logs
- Usually a dependency or build config issue
- Current build: ✅ Working (esbuild minifier)

### Wrong URL
- GitHub Pages URL: `https://[username].github.io/[repo-name]/`
- For this repo: `https://ambot9.github.io/nexwork-website/`

### Custom Domain
After Pages is working, you can add a custom domain:
1. Settings → Pages → Custom domain
2. Enter your domain (e.g., `nexwork.app`)
3. Update DNS records with your provider

## Quick Checklist

- [ ] Go to Settings → Pages
- [ ] Select "GitHub Actions" as source
- [ ] Click Save
- [ ] Trigger workflow (or push to main)
- [ ] Wait for green checkmark
- [ ] Visit https://ambot9.github.io/nexwork-website/
- [ ] 🎉 Website is live!

## Status

**Build:** ✅ Working (esbuild minifier fixed the build)
**Deployment:** ⏳ Waiting for GitHub Pages to be enabled
**Site:** ⏳ Will be live once Pages is enabled

---

**After enabling Pages, your professional Nexwork website will be live! 🚀**
