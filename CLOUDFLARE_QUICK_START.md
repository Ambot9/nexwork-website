# 🚀 Cloudflare Pages + nexwork.dev - Quick Start

You've already added nexwork.dev to Cloudflare! Now let's get your website live.

## Current Status

✅ Domain added to Cloudflare: `nexwork.dev`
⏳ Need to: Deploy website to Cloudflare Pages
⏳ Need to: Connect domain to Pages

## Step-by-Step Setup (10 Minutes)

### Step 1: Go to Pages

1. Open Cloudflare dashboard: https://dash.cloudflare.com
2. Click **"Workers & Pages"** in left sidebar
3. Click **"Create application"**
4. Click **"Pages"** tab
5. Click **"Connect to Git"**

### Step 2: Connect GitHub

1. Click **"Connect GitHub"**
2. Click **"Authorize Cloudflare Pages"**
3. Select **"Only select repositories"**
4. Choose: `nexwork-website`
5. Click **"Install & Authorize"**

### Step 3: Configure Build

1. **Select your repo:** `nexwork-website`
2. **Project name:** `nexwork-website` (or `nexwork`)
3. **Production branch:** `main`
4. **Build settings:**
   - Framework preset: **Vue**
   - Build command: `npm run build`
   - Build output directory: `dist`
5. Click **"Save and Deploy"**

### Step 4: Wait for First Build

- Build takes 2-3 minutes
- You'll see live build logs
- When done, you get: `nexwork-website.pages.dev`
- Click the URL to test!

### Step 5: Connect Your Domain

**Option A: Automatic (Recommended)**

1. In your Pages project dashboard
2. Click **"Custom domains"** tab
3. Click **"Set up a custom domain"**
4. Enter: `nexwork.dev`
5. Click **"Continue"**
6. Cloudflare automatically creates DNS records
7. Click **"Activate domain"**
8. Done! SSL is automatic.

**Option B: Manual DNS (If Automatic Fails)**

Go back to: https://dash.cloudflare.com → nexwork.dev → DNS

Add these records:

**Record 1:**
```
Type: CNAME
Name: @
Target: nexwork-website.pages.dev
Proxy: ON (orange cloud)
TTL: Auto
```

**Record 2:**
```
Type: CNAME  
Name: www
Target: nexwork-website.pages.dev
Proxy: ON (orange cloud)
TTL: Auto
```

Then in Pages → Custom domains → Add `nexwork.dev`

### Step 6: Test Your Site

Wait 5-10 minutes, then visit:
- https://nexwork.dev
- https://www.nexwork.dev

Both should work with HTTPS! 🎉

## Troubleshooting

### "Records we found: 0"
- This is normal before deploying to Pages
- Deploy to Pages first, THEN add DNS

### Build fails?
Check build logs for errors. Common fixes:
- Node version: Should be 20
- Build command: `npm run build`
- Output directory: `dist`

### Domain not working?
- Wait 10-30 minutes for DNS propagation
- Check DNS records are correct
- Verify proxy is ON (orange cloud)
- Check Pages custom domain is added

### SSL not working?
- Should be automatic with Cloudflare
- Make sure proxy is ON (orange cloud)
- Wait 5 minutes and try again

## What You Get (All FREE)

✅ Lightning-fast website
✅ Global CDN (300+ cities)
✅ Automatic HTTPS/SSL
✅ Unlimited bandwidth
✅ DDoS protection
✅ Auto-deploy on git push
✅ Custom domain (nexwork.dev)

## Cost

```
Domain: $12/year (nexwork.dev)
Hosting: $0 (Cloudflare Pages)
CDN: $0 (included)
SSL: $0 (automatic)
Bandwidth: $0 (unlimited!)
Total: $12/year
```

## Next Steps

1. ✅ Domain added to Cloudflare
2. ⏳ Deploy to Cloudflare Pages (do this now!)
3. ⏳ Connect domain to Pages
4. ⏳ Test site at nexwork.dev
5. 🎉 Your professional site is live!

---

**Ready? Let's deploy!** Go to: https://dash.cloudflare.com
