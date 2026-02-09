# 🌐 Custom Domain Setup Guide

Complete guide to connect your custom domain to Nexwork website.

## 📦 What You Need

1. **Domain** (~$10/year) - Buy from Namecheap or Cloudflare
2. **Hosting** (FREE) - Netlify or GitHub Pages
3. **10 minutes** - Setup time

---

## Option A: Netlify + Custom Domain (Recommended) ⭐

### Why Netlify?
- ✅ Easiest setup (literally 3 clicks)
- ✅ Automatic SSL (instant, no waiting)
- ✅ Fast CDN (global)
- ✅ Zero configuration needed
- ✅ Works perfectly with custom domains

### Step 1: Deploy to Netlify (5 minutes)

1. **Sign up / Log in:**
   - Go to https://app.netlify.com
   - Click "Sign up" → Choose "GitHub"
   - Authorize Netlify to access GitHub

2. **Import your repository:**
   - Click "Add new site" → "Import an existing project"
   - Click "GitHub"
   - Search for "nexwork-website"
   - Click on it

3. **Configure build (auto-detected):**
   ```
   Build command: npm run build
   Publish directory: dist
   ```
   - These should be pre-filled
   - Click "Deploy site"

4. **Wait 2 minutes:**
   - Netlify builds and deploys
   - You'll get a URL like: `random-name-123456.netlify.app`

5. **Test it:**
   - Click the URL
   - Your site is live!

### Step 2: Add Custom Domain to Netlify (2 minutes)

1. **In Netlify dashboard:**
   - Go to your site
   - Click "Domain settings" (top)
   - Click "Add custom domain"
   - Enter your domain: `nexwork.app` (example)
   - Click "Verify"
   - Click "Add domain"

2. **Netlify will show DNS instructions**

### Step 3: Configure DNS at Your Registrar (3 minutes)

Go to your domain registrar (where you bought the domain) and add these DNS records:

#### If using Namecheap:
1. Go to Domain List → Manage
2. Click "Advanced DNS"
3. Add these records:

```
Type        | Host  | Value              | TTL
A Record    | @     | 75.2.60.5          | Automatic
CNAME       | www   | [your-site].netlify.app | Automatic
```

Replace `[your-site]` with your actual Netlify subdomain.

#### If using Cloudflare Registrar:
1. Go to your domain → DNS
2. Add these records:

```
Type   | Name | Content                    | Proxy
A      | @    | 75.2.60.5                  | OFF (gray cloud)
CNAME  | www  | [your-site].netlify.app    | OFF (gray cloud)
```

⚠️ **Important:** Turn proxy OFF for initial setup (use gray cloud, not orange)

### Step 4: Wait & Verify

1. **Wait 5-60 minutes** for DNS propagation
2. **Netlify automatically provisions SSL certificate**
3. **Visit your domain** - It works with HTTPS! 🎉

#### Check DNS Propagation:
- Use: https://dnschecker.org
- Enter your domain
- Check A record and CNAME

---

## Option B: GitHub Pages + Custom Domain

### Step 1: Enable GitHub Pages

1. Go to: https://github.com/Ambot9/nexwork-website/settings/pages
2. Source: Select "GitHub Actions"
3. Custom domain: Enter `nexwork.app` (your domain)
4. Click Save
5. Wait for DNS check to pass

### Step 2: Configure DNS

#### For GitHub Pages (Without Cloudflare):

Add these A records at your registrar:

```
Type   | Name | Value
A      | @    | 185.199.108.153
A      | @    | 185.199.109.153
A      | @    | 185.199.110.153
A      | @    | 185.199.111.153
CNAME  | www  | ambot9.github.io
```

#### For GitHub Pages + Cloudflare (Better):

1. **Add site to Cloudflare:**
   - Sign up at https://cloudflare.com (free)
   - Add your domain
   - Update nameservers at your registrar to Cloudflare's nameservers

2. **Add DNS records in Cloudflare:**
   ```
   Type   | Name | Value              | Proxy
   A      | @    | 185.199.108.153    | ON (orange cloud)
   A      | @    | 185.199.109.153    | ON
   A      | @    | 185.199.110.153    | ON
   A      | @    | 185.199.111.153    | ON
   CNAME  | www  | ambot9.github.io   | ON
   ```

3. **Configure Cloudflare SSL:**
   - Go to SSL/TLS → Overview
   - Set encryption mode: **Full**

4. **Wait 24 hours:**
   - GitHub provisions SSL certificate
   - Cloudflare adds CDN + DDoS protection

---

## 🔍 Troubleshooting

### Domain not working after 1 hour?

1. **Check DNS propagation:**
   - Use https://dnschecker.org
   - Should show your new DNS records globally

2. **Check DNS records are correct:**
   - A record pointing to hosting provider's IP
   - CNAME for www subdomain

3. **For Netlify:**
   - Check Domain settings in Netlify dashboard
   - Should show "DNS configured correctly"

4. **For GitHub Pages:**
   - Check repository settings → Pages
   - Should show "DNS check successful"

### SSL certificate not working?

**For Netlify:**
- Should be automatic and instant
- If not, check DNS is pointing correctly
- Click "Verify DNS configuration" in Netlify

**For GitHub Pages:**
- Takes up to 24 hours
- Make sure DNS is correct
- Check "Enforce HTTPS" is enabled in settings

**For Cloudflare:**
- Set SSL/TLS mode to "Full" (not "Flexible")
- Wait up to 24 hours for GitHub to issue certificate

### www vs non-www?

Both should work! Set up:
- Root domain: `nexwork.app`
- WWW subdomain: `www.nexwork.app`

Most platforms automatically redirect between them.

---

## 💰 Cost Breakdown

### Total Annual Cost: ~$10-15/year

**Domain Registration:**
- Namecheap: $8-12/year (.com, .app)
- Cloudflare Registrar: $9-10/year (at cost)
- Google Domains: $12/year

**Hosting:**
- Netlify: FREE
- GitHub Pages: FREE
- Vercel: FREE

**SSL Certificate:**
- Let's Encrypt (via hosting): FREE
- Manual SSL: $0-50/year (not needed!)

**CDN:**
- Included in all free hosting: FREE

**Total: Just domain cost (~$10/year)**

---

## 🎯 My Recommendation

### Best Setup: Namecheap + Netlify

1. **Buy domain:** Namecheap.com
   - Search for `nexwork.app` or `getnexwork.com`
   - Buy for 1 year (~$10)
   - Enable free WHOIS privacy

2. **Deploy to Netlify:**
   - Import from GitHub (5 minutes)
   - Add custom domain (2 minutes)
   - Configure DNS (3 minutes)

3. **Done!**
   - Site live with HTTPS
   - Fast global CDN
   - Auto-deploys on git push

**Total Time:** 15 minutes
**Total Cost:** ~$10/year

---

## 📝 Domain Suggestions

Good domains for Nexwork:

**Recommended (.app domain):**
- `nexwork.app` - Clean, modern
- `getnexwork.app` - Call to action
- Cost: ~$10-15/year

**Alternatives (.com domain):**
- `nexwork.com` - May be taken
- `getnexwork.com` - Good alternative
- `nexworkapp.com` - Available
- `usenexwork.com` - Action-focused
- Cost: ~$10-12/year

**Developer-focused (.dev domain):**
- `nexwork.dev` - For developers
- Cost: ~$12-15/year

**Tech-focused (.io domain):**
- `nexwork.io` - Tech startup vibe
- Cost: ~$30-35/year (more expensive)

Check availability at:
- https://www.namecheap.com
- https://www.cloudflare.com/products/registrar/

---

## ✅ Post-Setup Checklist

After everything is working:

- [ ] Domain resolves to your site
- [ ] HTTPS (SSL) is working (green padlock)
- [ ] Both www and non-www work
- [ ] Site loads fast
- [ ] GitHub auto-deploys on push
- [ ] All pages accessible

Optional enhancements:
- [ ] Add Google Analytics
- [ ] Set up email forwarding (from Namecheap or Cloudflare)
- [ ] Configure DNS records for email (if needed)
- [ ] Add social meta tags for sharing

---

## 🚀 Ready to Buy Domain?

1. **Choose registrar:** Namecheap (recommended)
2. **Search for domain:** Try variations of `nexwork`
3. **Buy domain:** ~$10/year
4. **Deploy to Netlify:** 5 minutes
5. **Add custom domain:** 2 minutes
6. **Configure DNS:** 3 minutes
7. **Your site is live!** 🎉

**Need help?** Follow the steps above or ask me questions!

---

## 📧 Email Setup (Bonus)

Want email at your domain? (e.g., `hello@nexwork.app`)

### Free Options:

1. **Cloudflare Email Routing** (Free)
   - Forward unlimited emails
   - Setup: https://dash.cloudflare.com
   - No sending, only forwarding

2. **Yandex Connect** (Free)
   - 1000 emails/day
   - Full email hosting
   - Setup: https://connect.yandex.com

3. **Zoho Mail** (Free tier)
   - 5GB storage
   - Full email hosting
   - Setup: https://www.zoho.com/mail/

### Paid Options:

1. **Google Workspace** ($6/month)
   - Gmail at your domain
   - Full Google suite

2. **Microsoft 365** ($6/month)
   - Outlook at your domain
   - Full Office suite

---

**Questions? Just ask! I'll help you set everything up.** 🚀
