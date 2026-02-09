# ☁️ Cloudflare Pages Setup (100% FREE)

Deploy your Nexwork website to Cloudflare Pages - completely free with unlimited bandwidth!

## Why Cloudflare Pages?

- ✅ **Completely FREE** - No limits, no credit card
- ✅ **Unlimited bandwidth** - No 100GB cap like others
- ✅ **Unlimited builds** - Deploy as much as you want
- ✅ **Fastest CDN** - 300+ cities worldwide
- ✅ **Free SSL** - Automatic HTTPS
- ✅ **DDoS protection** - Included
- ✅ **GitHub integration** - Auto-deploy on push

## Setup Steps (5 Minutes)

### Step 1: Sign Up for Cloudflare

1. Go to: https://dash.cloudflare.com/sign-up
2. Enter email and create password
3. Verify email
4. **No credit card required!**

### Step 2: Connect GitHub

1. Go to: https://dash.cloudflare.com
2. Click "Workers & Pages" in left sidebar
3. Click "Create application"
4. Click "Pages" tab
5. Click "Connect to Git"
6. Click "Connect GitHub"
7. Authorize Cloudflare
8. Select "Only select repositories"
9. Choose: `nexwork-website`
10. Click "Install & Authorize"

### Step 3: Configure Build

1. **Select repository:** nexwork-website
2. **Project name:** nexwork-website
3. **Production branch:** main
4. **Build settings:**
   ```
   Framework preset: Vue
   Build command: npm run build
   Build output directory: dist
   ```
5. Click "Save and Deploy"

### Step 4: Wait for Deployment

- First build takes ~2-3 minutes
- You'll see a live build log
- When complete, you get a URL: `nexwork-website.pages.dev`

### Step 5: Visit Your Site!

Click the URL - your site is live with:
- ✅ HTTPS (SSL)
- ✅ Global CDN
- ✅ DDoS protection
- ✅ All FREE!

## Add Custom Domain

### Step 6: Add Your Domain

1. In Cloudflare Pages dashboard
2. Go to your project → "Custom domains"
3. Click "Set up a custom domain"
4. Enter your domain: `nexwork.app`
5. Click "Continue"

### Step 7A: If Domain NOT on Cloudflare Yet

Cloudflare will ask you to add the domain:

1. Click "Add site"
2. Enter your domain
3. Select FREE plan
4. Click "Continue"
5. Cloudflare scans your DNS records
6. Click "Continue"
7. **Update nameservers at your registrar:**
   - Go to your domain registrar (Namecheap, etc.)
   - Find "Nameservers" or "DNS Settings"
   - Change to Cloudflare's nameservers (shown on screen)
   - Example:
     ```
     vera.ns.cloudflare.com
     walt.ns.cloudflare.com
     ```
8. Wait 5-60 minutes for nameserver change
9. Cloudflare will email you when active

### Step 7B: If Domain Already on Cloudflare

Cloudflare automatically creates DNS records:
1. Go to DNS settings
2. You'll see new CNAME record pointing to your Pages site
3. Done! Domain connected.

### Step 8: SSL Certificate

- **Automatic!** Cloudflare provisions SSL instantly
- Your site has HTTPS immediately
- No configuration needed

## Auto-Deploy on Git Push

Every time you push to GitHub main branch:
1. Cloudflare automatically rebuilds
2. Deploys in 2-3 minutes
3. Site updates automatically

## Cost Breakdown

```
Domain Registration: ~$10/year (from Cloudflare or any registrar)
Cloudflare Pages Hosting: $0
CDN: $0
SSL: $0
Bandwidth: $0 (unlimited!)
Builds: $0 (unlimited!)
DDoS Protection: $0

Total: $10/year (just domain)
```

## Buy Domain from Cloudflare (Recommended)

### Why?
- At-cost pricing (no markup)
- Integrated with Pages
- Auto-SSL for domains
- One dashboard for everything

### How to Buy:

1. Go to: https://dash.cloudflare.com
2. Click "Domain Registration"
3. Click "Purchase Domains"
4. Search for domain (e.g., `nexwork.app`)
5. Add to cart
6. Complete purchase (~$10/year)
7. Domain automatically added to your account
8. Connect to Pages in 1 click

## Cloudflare Pages vs Others

| Feature | Cloudflare | Netlify | Vercel | GitHub Pages |
|---------|-----------|---------|--------|--------------|
| Price | FREE | FREE | FREE | FREE |
| Bandwidth | **Unlimited** | 100GB | 100GB | Unlimited* |
| Builds | **Unlimited** | 300min | 100min | Unlimited |
| CDN | ✅✅ Best | ✅ | ✅ | Basic |
| Speed | ✅✅ Fastest | ✅ | ✅ | ✅ |
| DDoS | ✅ Included | Extra $ | Extra $ | Basic |

**Winner: Cloudflare Pages** (for free tier)

## Troubleshooting

### Build fails?
- Check build logs in dashboard
- Verify Node version: 20
- Check build command: `npm run build`
- Output directory: `dist`

### Domain not working?
- Check DNS propagation: https://dnschecker.org
- Wait up to 24 hours for nameserver change
- Verify nameservers point to Cloudflare

### SSL not working?
- Should be automatic and instant
- Check SSL/TLS mode: "Full" or "Full (strict)"
- Wait 5 minutes and try again

## Next Steps

1. ✅ Sign up for Cloudflare (free)
2. ✅ Connect GitHub repository
3. ✅ Deploy site (auto-build)
4. ✅ Buy domain (optional, ~$10/year)
5. ✅ Connect custom domain
6. ✅ Done! Site is live with HTTPS

**Everything is FREE except the domain (~$10/year)!**

## Support

- Cloudflare Docs: https://developers.cloudflare.com/pages/
- Community: https://community.cloudflare.com/
- Support: Available even on free plan

---

**Cloudflare Pages = Best free hosting for your website! 🚀**
