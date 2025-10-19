# Vercel Deployment Guide for BiomixX Website

Vercel is an excellent platform for deploying static websites like your BiomixX site. It offers automatic deployments, custom domains, HTTPS, and global CDN - perfect for investor presentations.

## Why Vercel for BiomixX?

✅ **Faster deployment** than AWS S3  
✅ **Automatic HTTPS** included  
✅ **Global CDN** for fast loading worldwide  
✅ **Custom domains** free  
✅ **Git integration** for easy updates  
✅ **Preview deployments** for testing  
✅ **Analytics** included  
✅ **Zero configuration** needed  

## Method 1: Deploy via Vercel CLI (Recommended)

### Step 1: Install Vercel CLI

```bash
npm install -g vercel
```

Or using other package managers:

```bash
# Using yarn
yarn global add vercel

# Using pnpm
pnpm add -g vercel

# Using Homebrew (macOS)
brew install vercel
```

### Step 2: Login to Vercel

```bash
vercel login
```

This will open your browser to authenticate with Vercel.

### Step 3: Deploy Your Website

Navigate to your BiomixX website directory and run:

```bash
vercel
```

Follow the prompts:
- **Set up and deploy?** → Yes
- **Which scope?** → Choose your account
- **Link to existing project?** → No (for first deployment)
- **What's your project's name?** → `biomixx-website` (or your preferred name)
- **In which directory is your code located?** → `./` (current directory)

### Step 4: Access Your Website

After deployment, you'll get a URL like:
```
https://biomixx-website.vercel.app
```

## Method 2: Deploy via Vercel Dashboard (Web Interface)

### Step 1: Create Vercel Account

1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub, GitLab, or Bitbucket
3. Complete account setup

### Step 2: Import Project

1. Click "New Project" on your dashboard
2. Choose "Browse All Templates" or "Import Git Repository"
3. If uploading files directly:
   - Click "Deploy" 
   - Drag and drop your website files
   - Or click "Browse" to select files

### Step 3: Configure Project

1. **Project Name**: `biomixx-website`
2. **Framework Preset**: Other (since it's vanilla HTML/CSS/JS)
3. **Root Directory**: Leave as default
4. **Build Command**: Leave empty (no build needed)
5. **Output Directory**: Leave empty
6. **Install Command**: Leave empty

### Step 4: Deploy

Click "Deploy" and wait for the deployment to complete.

## Method 3: Deploy via Git Integration (Best for Updates)

### Step 1: Push to GitHub

1. Create a new repository on GitHub
2. Push your BiomixX website files:

```bash
git init
git add .
git commit -m "Initial BiomixX website"
git branch -M main
git remote add origin https://github.com/yourusername/biomixx-website.git
git push -u origin main
```

### Step 2: Connect to Vercel

1. Go to Vercel Dashboard
2. Click "New Project"
3. Import your GitHub repository
4. Configure settings (same as Method 2)
5. Click "Deploy"

### Step 3: Automatic Deployments

Now every time you push to GitHub, Vercel will automatically redeploy your website!

## Custom Domain Setup

### Step 1: Add Domain in Vercel

1. Go to your project dashboard
2. Click "Settings" → "Domains"
3. Add your domain (e.g., `biomixx.com`)
4. Follow the DNS configuration instructions

### Step 2: Configure DNS

**For most domain providers:**
- Add a CNAME record pointing to `cname.vercel-dns.com`
- Or add an A record pointing to Vercel's IP addresses

**Example DNS records:**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com

Type: A
Name: @
Value: 76.76.19.61
```

### Step 3: SSL Certificate

Vercel automatically provides SSL certificates for custom domains - no additional setup needed!

## Environment Variables (If Needed)

If you need to add environment variables:

1. Go to Project Settings → Environment Variables
2. Add variables like:
   - `CONTACT_EMAIL=info@biomixx.com`
   - `ANALYTICS_ID=your-analytics-id`

## Performance Optimization

### Vercel Analytics

Enable analytics in your project:
1. Go to Project Settings → Analytics
2. Enable Vercel Analytics
3. Add tracking code to your HTML

### Image Optimization

Vercel automatically optimizes images. For better performance:
1. Use WebP format when possible
2. Compress images before uploading
3. Use appropriate image sizes

## Form Handling

Since your forms need backend processing, here are options:

### Option 1: Vercel Functions (Serverless)

Create `api/contact.js`:

```javascript
export default function handler(req, res) {
  if (req.method === 'POST') {
    const { name, email, message } = req.body;
    
    // Process form data
    // Send email, save to database, etc.
    
    res.status(200).json({ success: true });
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
}
```

### Option 2: Third-party Services

- **Formspree**: Easy form handling
- **Netlify Forms**: Similar to Vercel
- **Typeform**: Professional forms
- **Google Forms**: Free option

### Option 3: External API

Connect to your existing backend API.

## Deployment Commands Reference

```bash
# Deploy to production
vercel --prod

# Deploy preview
vercel

# Check deployment status
vercel ls

# View deployment logs
vercel logs

# Remove deployment
vercel remove

# Update domain
vercel domains add biomixx.com
```

## Troubleshooting

### Common Issues

**Build Errors:**
- Check that all file paths are correct
- Ensure no server-side code in static files
- Verify HTML syntax

**Domain Issues:**
- Check DNS propagation (can take 24-48 hours)
- Verify domain ownership
- Check SSL certificate status

**Performance Issues:**
- Enable Vercel Analytics
- Check Core Web Vitals
- Optimize images and assets

### Useful Commands

```bash
# Check Vercel CLI version
vercel --version

# Login status
vercel whoami

# List all projects
vercel ls

# Get project info
vercel inspect
```

## Cost Comparison

### Vercel Pricing
- **Hobby Plan**: Free (perfect for BiomixX)
  - Unlimited personal projects
  - 100GB bandwidth/month
  - Custom domains
  - Automatic HTTPS

- **Pro Plan**: $20/month
  - Team collaboration
  - Advanced analytics
  - More bandwidth

### vs AWS S3 + CloudFront
- **Vercel**: Easier setup, better developer experience
- **AWS**: More control, potentially lower costs for high traffic

## Best Practices

1. **Use Git Integration**: Automatic deployments on code changes
2. **Enable Analytics**: Track website performance
3. **Set up Custom Domain**: Professional appearance for investors
4. **Test Locally**: Use `vercel dev` for local testing
5. **Monitor Performance**: Use Vercel Analytics dashboard

## Next Steps After Deployment

1. **Test All Pages**: Verify all links and forms work
2. **Mobile Testing**: Check responsiveness on different devices
3. **Performance Check**: Use Google PageSpeed Insights
4. **SEO Setup**: Add meta tags and sitemap
5. **Analytics**: Set up Google Analytics or Vercel Analytics

## Quick Start Summary

```bash
# 1. Install Vercel CLI
npm install -g vercel

# 2. Login
vercel login

# 3. Deploy
vercel

# 4. Add custom domain (optional)
vercel domains add your-domain.com
```

Your BiomixX website will be live at `https://biomixx-website.vercel.app` in minutes!

Vercel is perfect for your investor presentations - fast, reliable, and professional. The automatic HTTPS and global CDN ensure your website loads quickly worldwide.
