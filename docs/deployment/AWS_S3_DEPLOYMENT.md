# AWS S3 Deployment Guide for BiomixX Website

## Overview
This guide will help you deploy the BiomixX website to AWS S3.

**Target Bucket:** `biomixx.net`  
**Region:** `us-west-2`  
**Website URL:** `https://biomixx.net.s3.us-west-2.amazonaws.com/index.html`

## Prerequisites

### 1. AWS Account Credentials
- **Username:** jianfengren
- **Password:** sK1B#{5#
- **Console:** https://338982144448.signin.aws.amazon.com/console
- **Account ID:** 338982144448

### 2. Install AWS CLI
If not already installed:

**macOS:**
```bash
brew install awscli
```

**Linux:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

**Windows:**
Download from: https://aws.amazon.com/cli/

## Setup Instructions

### Step 1: Configure AWS CLI

Run the following command and enter your credentials when prompted:
```bash
aws configure
```

When prompted, enter:
- **AWS Access Key ID:** (Get from AWS console > IAM > Security credentials)
- **AWS Secret Access Key:** (Get from AWS console > IAM > Security credentials)
- **Default region name:** `us-west-2`
- **Default output format:** `json`

### Step 2: Verify AWS Configuration

Check your configuration:
```bash
aws configure list
```

### Step 3: Deploy Website

**Option A: Use the deployment script (Recommended)**
```bash
./deploy_to_s3.sh
```

**Option B: Manual deployment**

1. Create the S3 bucket (if not exists):
```bash
aws s3 mb s3://biomixx.net --region us-west-2
```

2. Enable static website hosting:
```bash
aws s3 website s3://biomixx.net \
    --index-document index.html \
    --error-document index.html
```

3. Set bucket policy for public access:
```bash
cat > bucket-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::biomixx.net/*"
        }
    ]
}
EOF

aws s3api put-bucket-policy \
    --bucket biomixx.net \
    --policy file://bucket-policy.json
```

4. Upload files:
```bash
aws s3 sync . s3://biomixx.net \
    --exclude "*.md" \
    --exclude "*.git/*" \
    --exclude ".DS_Store" \
    --exclude "deploy_to_s3.sh"
```

## Accessing Your Website

### S3 Endpoint (HTTPS):
https://biomixx.net.s3.us-west-2.amazonaws.com/index.html

### Website Endpoint (HTTP):
http://biomixx.net.s3-website-us-west-2.amazonaws.com

### Direct Object URL:
https://biomixx.net.s3.us-west-2.amazonaws.com/index.html

## File Structure
```
BiomixX Website/
├── index.html              # Home page
├── about.html              # About page
├── contact.html            # Contact & demo request
├── platform.html           # Platform overview
├── use-cases.html          # Use cases
├── technology.html         # Technology details
├── investors.html          # Investor information
├── schedule.html           # Schedule demo
├── styles.css              # Main stylesheet
├── script.js               # JavaScript
└── assets/
    └── images/
        └── biomixx-logo.svg  # Logo file
```

## Troubleshooting

### 1. Access Denied Error
If you see "Access Denied", the bucket policy might not be set correctly:
```bash
aws s3api put-bucket-policy \
    --bucket biomixx.net \
    --policy file://bucket-policy.json
```

### 2. 404 Error on Pages
Make sure to either:
- Upload `index.html` as the error document
- Configure proper routing in the bucket policy

### 3. SSL Certificate
For HTTPS support, consider using AWS CloudFront:
1. Create a CloudFront distribution
2. Point origin to `biomixx.net.s3.us-west-2.amazonaws.com`
3. Configure SSL certificate

## Updating the Website

To update the website after making changes:

```bash
# Simply run the deployment script again
./deploy_to_s3.sh

# Or manually sync
aws s3 sync . s3://biomixx.net \
    --exclude "*.md" \
    --exclude "*.git/*" \
    --exclude ".DS_Store" \
    --delete
```

The `--delete` flag removes files from S3 that are not in your local directory.

## Security Best Practices

1. **Never commit credentials** to version control
2. **Use IAM users** instead of root account
3. **Rotate credentials** regularly
4. **Enable versioning** on your S3 bucket for backups
5. **Set up CloudWatch** for monitoring

## Additional Resources

- AWS S3 Documentation: https://docs.aws.amazon.com/s3/
- AWS CLI Documentation: https://docs.aws.amazon.com/cli/
- Static Website Hosting: https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html

## Support

For issues or questions:
- Email: info@biomixx.com
- AWS Support: https://console.aws.amazon.com/support/

---

**Note:** After deployment, it may take a few minutes for changes to propagate across all AWS edge locations.

