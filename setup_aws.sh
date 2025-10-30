#!/bin/bash

# AWS Setup Script for BiomixX Website Deployment
# This script helps configure AWS CLI with credentials

echo "============================================"
echo "BiomixX AWS Setup & Deployment"
echo "============================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Step 1: Configure AWS CLI${NC}"
echo ""
echo "You need to get your AWS Access Keys from the AWS Console:"
echo ""
echo -e "${GREEN}1. Go to: https://338982144448.signin.aws.amazon.com/console${NC}"
echo "2. Log in with:"
echo "   Username: jianfengren"
echo "   Password: sK1B#{5#"
echo "3. Go to IAM > Users > Your username"
echo "4. Click 'Security credentials' tab"
echo "5. Create access key if you don't have one"
echo ""
echo -e "${YELLOW}Press Enter when you have your Access Key ID and Secret Access Key ready...${NC}"
read

echo ""
echo "Now let's configure AWS CLI..."
echo ""

# Configure AWS CLI
aws configure

echo ""
echo -e "${BLUE}Step 2: Verify Configuration${NC}"
echo ""
echo "Your AWS configuration:"
aws configure list

echo ""
echo -e "${BLUE}Step 3: Test AWS Connection${NC}"
echo ""
echo "Testing AWS connection..."
aws sts get-caller-identity

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ AWS credentials are working correctly!${NC}"
    echo ""
    echo -e "${BLUE}Step 4: Deploy to S3${NC}"
    echo ""
    echo "Ready to deploy? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        ./deploy_to_s3.sh
    else
        echo "You can deploy later by running: ./deploy_to_s3.sh"
    fi
else
    echo -e "${RED}✗ AWS credentials failed. Please check your access keys.${NC}"
    exit 1
fi



