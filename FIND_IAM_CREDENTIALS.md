# How to Find Your AWS Access Keys in the Console

## ⚠️ Important: Change Region First

I noticed you're currently in **us-east-2** region. The BiomixX website bucket is in **us-west-2**. 

### To change region:
1. Look at the top-right of the AWS Console
2. You'll see "us-east-2" or a region selector
3. Click it and select **"us-west-2"** (Oregon)
4. Or go directly to: https://us-west-2.console.aws.amazon.com

## Finding IAM User Security Credentials

### Method 1: Direct Navigation (Easiest)

1. **After changing to us-west-2**, click on your **username** in the top-right corner
2. Click **"Security credentials"**
3. Scroll down to **"Access keys"** section
4. Click **"Create access key"**
5. Choose **"Command Line Interface (CLI)"**
6. Click **"Next"**
7. Click **"Create access key"**
8. Download or copy both:
   - **Access key ID**
   - **Secret access key** (only shown once!)

### Method 2: Through IAM Dashboard

1. In the AWS Console search bar at the top, type: **"IAM"**
2. Click on **"IAM"** service
3. In the left sidebar, click **"Users"**
4. Click on your username (**"jianfengren"**)
5. Click the **"Security credentials"** tab
6. Scroll to **"Access keys"** section
7. Click **"Create access key"**

### What to Do With These Keys

Once you have your Access Key ID and Secret Access Key, run:

```bash
aws configure
```

When prompted, enter:
- **AWS Access Key ID:** [paste your access key]
- **AWS Secret Access Key:** [paste your secret key]
- **Default region name:** `us-west-2` (very important!)
- **Default output format:** `json`

Then test the connection:

```bash
aws sts get-caller-identity
```

This should show your AWS account information if configured correctly.

## Alternative: Use Your Existing Credentials

If your friend provided credentials that already have access to the account, you can also:

1. Check if you have any saved credentials
2. Configure AWS CLI with those credentials directly

## Quick Steps Summary

```
1. Change region to us-west-2
2. Click your username (top-right)
3. Click "Security credentials"
4. Create access key
5. Copy both keys
6. Run: aws configure
7. Paste the keys when prompted
8. Make sure region is: us-west-2
```

## Need More Help?

If you're still having trouble:
- Try the AWS Console search: Type "IAM" and look for Identity and Access Management
- The IAM service is usually accessible from any region
- Make sure you're logged in as the correct user: jianfengren

