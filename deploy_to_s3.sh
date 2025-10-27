#!/bin/bash

# AWS S3 Deployment Script for BiomixX Website
# Bucket: biomixx-web
# Region: us-west-2

echo "🚀 Starting deployment to AWS S3..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
BUCKET_NAME="biomixx.net"
REGION="us-west-2"
PROFILE="default"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED}❌ AWS CLI is not installed.${NC}"
    echo "Please install it first: https://aws.amazon.com/cli/"
    exit 1
fi

echo -e "${GREEN}✓ AWS CLI found${NC}"

# Check if AWS credentials are configured
if ! aws configure list &> /dev/null; then
    echo -e "${RED}❌ AWS credentials not configured.${NC}"
    echo "Please run: aws configure"
    echo "Or use the provided credentials to set up AWS CLI"
    exit 1
fi

echo -e "${GREEN}✓ AWS credentials configured${NC}"

# Check if bucket exists
if aws s3 ls "s3://$BUCKET_NAME" 2>&1 | grep -q 'NoSuchBucket'; then
    echo -e "${YELLOW}⚠️  Bucket doesn't exist. Creating bucket...${NC}"
    aws s3 mb "s3://$BUCKET_NAME" --region "$REGION"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Bucket created successfully${NC}"
    else
        echo -e "${RED}❌ Failed to create bucket${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✓ Bucket exists${NC}"
fi

# Configure bucket for website hosting
echo "📝 Configuring bucket for static website hosting..."
aws s3 website "s3://$BUCKET_NAME" \
    --index-document index.html \
    --error-document index.html

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Website hosting configured${NC}"
else
    echo -e "${RED}❌ Failed to configure website hosting${NC}"
    exit 1
fi

# Disable block public access settings first
echo "🔓 Disabling block public access settings..."
aws s3api put-public-access-block \
    --bucket "$BUCKET_NAME" \
    --public-access-block-configuration \
    BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Block public access settings disabled${NC}"
else
    echo -e "${RED}❌ Failed to disable block public access settings${NC}"
    exit 1
fi

# Wait a moment for the settings to propagate
echo "⏳ Waiting for settings to propagate..."
sleep 5

# Set bucket policy for public read access
echo "🔓 Setting bucket policy for public access..."

POLICY="{
    \"Version\": \"2012-10-17\",
    \"Statement\": [
        {
            \"Sid\": \"PublicReadGetObject\",
            \"Effect\": \"Allow\",
            \"Principal\": \"*\",
            \"Action\": \"s3:GetObject\",
            \"Resource\": \"arn:aws:s3:::${BUCKET_NAME}/*\"
        }
    ]
}"

echo "$POLICY" | aws s3api put-bucket-policy \
    --bucket "$BUCKET_NAME" \
    --policy file:///dev/stdin

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Bucket policy set${NC}"
else
    echo -e "${RED}❌ Failed to set bucket policy${NC}"
    echo "Note: This might be due to AWS account restrictions. Check AWS console for more details."
    # Don't exit here - the website might still work with bucket ACLs
fi

# Upload files
echo "📤 Uploading files to S3..."
aws s3 sync . "s3://$BUCKET_NAME" \
    --exclude "*.md" \
    --exclude "*.git/*" \
    --exclude "*.DS_Store" \
    --exclude ".gitignore" \
    --exclude "deploy_to_s3.sh" \
    --delete

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Files uploaded successfully${NC}"
else
    echo -e "${RED}❌ Failed to upload files${NC}"
    exit 1
fi

# Website URL
WEBSITE_URL="https://${BUCKET_NAME}.s3.${REGION}.amazonaws.com/index.html"
WEBSITE_ENDPOINT="http://${BUCKET_NAME}.s3-website-${REGION}.amazonaws.com"
echo ""
echo -e "${GREEN}🎉 Deployment completed successfully!${NC}"
echo ""
echo "Your website is now live at:"
echo -e "${GREEN}$WEBSITE_URL${NC}"
echo ""
echo "Note: It may take a few minutes for the changes to propagate."
echo ""
echo "Alternative S3 website endpoint:"
echo "$WEBSITE_ENDPOINT"
echo ""

