# 🚀 Quick Deployment Guide - BiomixX Website to AWS S3

## ✅ What We've Done

1. ✅ Created `index.html` (home page)
2. ✅ Updated all logo references in all HTML files
3. ✅ Installed AWS CLI on your system
4. ✅ Created deployment scripts for easy deployment

## 🎯 Next Steps

### Step 1: Get AWS Access Keys (5 minutes)

1. **Go to AWS Console:**
   - URL: https://338982144448.signin.aws.amazon.com/console
   - Username: `jianfengren`
   - Password: `sK1B#{5#`

2. **Navigate to IAM:**
   - Click on "IAM" in the services menu
   - Go to "Users" > `jianfengren`
   - Click "Security credentials" tab

3. **Create Access Key:**
   - Click "Create access key"
   - Choose "Command Line Interface (CLI)"
   - Download or copy both:
     - **Access Key ID**
     - **Secret Access Key** (only shown once!)

### Step 2: Configure AWS CLI (2 minutes)

Run the setup script:

```bash
./setup_aws.sh
```

When prompted, enter:
- **AWS Access Key ID:** (paste from step 1)
- **AWS Secret Access Key:** (paste from step 1)
- **Region:** `us-west-2`
- **Output format:** `json`

### Step 3: Deploy Your Website (1 minute)

The setup script will offer to deploy automatically, or run:

```bash
./deploy_to_s3.sh
```

### Step 4: Access Your Website

Once deployed, your website will be live at:

🌐 **Primary URL:**
```
https://biomixx.net.s3.us-west-2.amazonaws.com/index.html
```

🔄 **Alternative URL:**
```
http://biomixx.net.s3-website-us-west-2.amazonaws.com
```

## 📁 Project Files

All your website files are ready:

- ✅ `index.html` - Home page
- ✅ `about.html` - About page
- ✅ `contact.html` - Contact & demo
- ✅ `platform.html` - Platform overview
- ✅ `use-cases.html` - Use cases
- ✅ `technology.html` - Technology
- ✅ `investors.html` - Investors
- ✅ `schedule.html` - Schedule demo
- ✅ `styles.css` - Styling
- ✅ `script.js` - Interactive features
- ✅ `assets/images/biomixx-logo.svg` - Logo

## 🔄 Updating Your Website

After making changes to any files, simply run:

```bash
./deploy_to_s3.sh
```

This will sync all changes to S3.

## 🆘 Troubleshooting

### Issue: "Access Denied"
**Solution:** Make sure the bucket policy is set correctly. Re-run `./deploy_to_s3.sh`

### Issue: "Bucket doesn't exist"
**Solution:** The deployment script will create it automatically.

### Issue: Website shows "Access Denied"
**Solution:** Make sure bucket policy allows public read access. Check `AWS_S3_DEPLOYMENT.md` for the policy.

### Issue: Changes not visible
**Solution:** Clear your browser cache or wait a few minutes for propagation.

## 📊 Website Structure

```
BiomixX/
├── index.html              ← Home/Landing page
├── about.html              ← About BiomixX
├── contact.html            ← Contact & demo request
├── platform.html           ← Platform overview
├── use-cases.html          ← Use cases
├── technology.html         ← Technology
├── investors.html          ← Investor information
├── schedule.html           ← Schedule demo
├── styles.css              ← All styling
├── script.js               ← Interactivity
└── assets/
    └── images/
        └── biomixx-logo.svg
```

## 🎨 Customization

All content can be customized by editing the HTML files. The website uses:
- Modern, responsive design
- Inter font (from Google Fonts)
- Clean, professional styling
- Mobile-friendly navigation

## 📞 Need Help?

- AWS Documentation: https://docs.aws.amazon.com/
- S3 Website Hosting: https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html
- AWS Console: https://338982144448.signin.aws.amazon.com/console

---

**Ready to deploy?** Just run `./setup_aws.sh` and follow the prompts! 🚀

