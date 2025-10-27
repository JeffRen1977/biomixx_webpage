#!/bin/bash

echo "Checking for existing AWS configuration..."

if [ -f ~/.aws/credentials ]; then
    echo "✓ Found AWS credentials file"
    echo ""
    echo "Current AWS configuration:"
    aws configure list
    echo ""
    echo "Testing connection..."
    aws sts get-caller-identity
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 You already have working AWS credentials!"
        echo "You can proceed directly to deployment:"
        echo "   ./deploy_to_s3.sh"
    else
        echo "✗ Credentials found but not working"
    fi
else
    echo "No AWS credentials file found"
    echo ""
    echo "You need to get access keys from the account administrator"
fi
