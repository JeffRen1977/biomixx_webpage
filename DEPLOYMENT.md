# AWS S3 Deployment Guide for BiomixX Website

This guide will walk you through deploying your static BiomixX website to AWS S3.

## Prerequisites

1. **AWS Account**: You need an active AWS account
2. **AWS CLI**: Install and configure AWS CLI on your local machine
3. **Domain Name** (optional): For custom domain setup

## Method 1: Using AWS CLI (Recommended)

### Step 1: Install AWS CLI

**For macOS:**
```bash
brew install awscli
```

**For Windows:**
Download from: https://aws.amazon.com/cli/

**For Linux:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Step 2: Configure AWS CLI

```bash
aws configure
```

Enter your credentials:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., `us-east-1`)
- Default output format (e.g., `json`)

### Step 3: Create S3 Bucket

```bash
# Replace 'biomixx-website' with your desired bucket name
aws s3 mb s3://biomixx-website
```

**Note:** Bucket names must be globally unique. If the name is taken, try variations like `biomixx-website-2024` or `biomixx-investor-site`.

### Step 4: Configure Bucket for Static Website Hosting

```bash
aws s3 website s3://biomixx-website --index-document index.html --error-document index.html
```

### Step 5: Upload Website Files

Navigate to your website directory and upload files:

```bash
# From your BioMixx_Webpage directory
aws s3 sync . s3://biomixx-website --exclude "*.md" --exclude ".git/*" --exclude "README.md"
```

### Step 6: Set Bucket Policy for Public Access

Create a file called `bucket-policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::biomixx-website/*"
        }
    ]
}
```

Apply the policy:

```bash
aws s3api put-bucket-policy --bucket biomixx-website --policy file://bucket-policy.json
```

### Step 7: Access Your Website

Your website will be available at:
```
http://biomixx-website.s3-website-us-east-1.amazonaws.com
```

Replace `us-east-1` with your actual region.

## Method 2: Using AWS Console (Web Interface)

### Step 1: Create S3 Bucket

1. Go to AWS S3 Console
2. Click "Create bucket"
3. Enter bucket name (must be globally unique)
4. Choose region
5. Uncheck "Block all public access"
6. Acknowledge the warning
7. Click "Create bucket"

### Step 2: Upload Files

1. Click on your bucket name
2. Click "Upload"
3. Add all your website files (HTML, CSS, JS)
4. Click "Upload"

### Step 3: Enable Static Website Hosting

1. Go to "Properties" tab
2. Scroll to "Static website hosting"
3. Click "Edit"
4. Select "Enable"
5. Set index document: `index.html`
6. Set error document: `index.html`
7. Click "Save changes"

### Step 4: Set Bucket Policy

1. Go to "Permissions" tab
2. Scroll to "Bucket policy"
3. Click "Edit"
4. Add the policy from Step 6 above
5. Replace `biomixx-website` with your bucket name
6. Click "Save changes"

## Method 3: Using AWS CloudFormation (Advanced)

Create a file called `website-stack.yaml`:

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'BiomixX Website S3 Bucket'

Parameters:
  BucketName:
    Type: String
    Description: Name for the S3 bucket
    Default: biomixx-website

Resources:
  WebsiteBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Ref BucketName
      PublicAccessBlockConfiguration:
        BlockPublicAcls: false
        BlockPublicPolicy: false
        IgnorePublicAcls: false
        RestrictPublicBuckets: false
      WebsiteConfiguration:
        IndexDocument: index.html
        ErrorDocument: index.html

  WebsiteBucketPolicy:
    Type: AWS::S3::BucketPolicy
    Properties:
      Bucket: !Ref WebsiteBucket
      PolicyDocument:
        Statement:
          - Effect: Allow
            Principal: '*'
            Action: s3:GetObject
            Resource: !Sub '${WebsiteBucket}/*'

Outputs:
  WebsiteURL:
    Description: URL of the website
    Value: !GetAtt WebsiteBucket.WebsiteURL
    Export:
      Name: !Sub '${AWS::StackName}-WebsiteURL'
```

Deploy with:

```bash
aws cloudformation create-stack --stack-name biomixx-website --template-body file://website-stack.yaml --parameters ParameterKey=BucketName,ParameterValue=biomixx-website
```

## Setting Up Custom Domain (Optional)

### Step 1: Purchase Domain

Buy a domain from Route 53 or another registrar.

### Step 2: Create CloudFront Distribution

1. Go to CloudFront Console
2. Click "Create distribution"
3. Set origin domain to your S3 bucket
4. Set origin path to empty
5. Set default root object to `index.html`
6. Configure caching behaviors
7. Create distribution

### Step 3: Configure DNS

1. Go to Route 53 Console
2. Create hosted zone for your domain
3. Create CNAME record pointing to CloudFront distribution
4. Update nameservers at your domain registrar

## HTTPS Setup (Recommended)

### Using CloudFront

1. Create CloudFront distribution (as above)
2. Request SSL certificate in ACM (AWS Certificate Manager)
3. Configure CloudFront to use the certificate
4. Set up custom domain with HTTPS

### Using AWS Certificate Manager

```bash
# Request certificate
aws acm request-certificate --domain-name biomixx.com --validation-method DNS
```

## Testing Your Deployment

### Local Testing

```bash
# Test locally before uploading
python -m http.server 8000
# Visit http://localhost:8000
```

### Post-Deployment Testing

1. Check all pages load correctly
2. Test forms (they won't submit without backend)
3. Verify mobile responsiveness
4. Check page load speeds

## Troubleshooting

### Common Issues

**403 Forbidden Error:**
- Check bucket policy is correctly applied
- Ensure public access is not blocked
- Verify bucket name in policy matches actual bucket

**404 Not Found:**
- Check index.html is uploaded
- Verify static website hosting is enabled
- Ensure correct index document name

**CORS Issues:**
- Add CORS configuration if needed
- Check CloudFront settings if using CDN

### Useful Commands

```bash
# Check bucket policy
aws s3api get-bucket-policy --bucket biomixx-website

# List bucket contents
aws s3 ls s3://biomixx-website --recursive

# Sync specific files only
aws s3 sync . s3://biomixx-website --exclude "*" --include "*.html" --include "*.css" --include "*.js"

# Delete all files
aws s3 rm s3://biomixx-website --recursive
```

## Cost Optimization

### S3 Storage Costs
- Standard storage: ~$0.023 per GB per month
- Website hosting: Free (only storage costs)

### CloudFront Costs (if used)
- First 1TB data transfer: $0.085 per GB
- Additional requests: $0.0075 per 10,000 requests

### Estimated Monthly Costs
- Small website (< 1GB): $0.02-0.05
- With CloudFront: $0.10-0.50
- With custom domain: Additional Route 53 costs

## Security Best Practices

1. **Use CloudFront**: Provides DDoS protection and caching
2. **Enable HTTPS**: Essential for production websites
3. **Monitor Access**: Set up CloudTrail for access logging
4. **Regular Updates**: Keep website content updated
5. **Backup**: Regularly backup your website files

## Next Steps

1. **Set up monitoring**: Use CloudWatch for performance monitoring
2. **Implement CI/CD**: Automate deployments with GitHub Actions
3. **Add analytics**: Integrate Google Analytics or AWS CloudWatch
4. **Form handling**: Set up Lambda functions for form submissions
5. **CDN optimization**: Configure CloudFront caching rules

Your BiomixX website is now ready for investor presentations and can be accessed globally through AWS S3!
