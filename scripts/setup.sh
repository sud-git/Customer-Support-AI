#!/bin/bash
# SFDX Setup Script for Customer Support AI Project
# This script automates the initial setup of the project

echo "========================================="
echo "Customer Support AI - SFDX Setup"
echo "========================================="
echo ""

# Check if SFDX CLI is installed
if ! command -v sfdx &> /dev/null; then
    echo "❌ Salesforce CLI (SFDX) is not installed."
    echo "Please install it from: https://developer.salesforce.com/tools/sfdxcli"
    exit 1
fi

echo "✅ SFDX CLI found"
echo ""

# Display current directory
echo "📁 Project Directory: $(pwd)"
echo ""

# Check for sfdx-project.json
if [ ! -f "sfdx-project.json" ]; then
    echo "❌ sfdx-project.json not found!"
    exit 1
fi

echo "✅ Project configuration found"
echo ""

# Step 1: Authorize Org
echo "Step 1: Authorize Your Salesforce Org"
echo "==========================================="
read -p "Enter org alias (e.g., MyOrg, MySandbox): " ORG_ALIAS

if [ -z "$ORG_ALIAS" ]; then
    ORG_ALIAS="MyOrg"
fi

read -p "Is this a Sandbox? (y/n): " IS_SANDBOX

if [ "$IS_SANDBOX" = "y" ]; then
    INSTANCE_URL="https://test.salesforce.com"
else
    INSTANCE_URL="https://login.salesforce.com"
fi

echo ""
echo "⏳ Authorizing $ORG_ALIAS at $INSTANCE_URL..."
sfdx force:auth:web:login --setalias "$ORG_ALIAS" --instanceurl "$INSTANCE_URL"

if [ $? -ne 0 ]; then
    echo "❌ Authorization failed!"
    exit 1
fi

echo "✅ Authorization successful"
echo ""

# Step 2: Set Default Org
echo "Step 2: Setting Default Org"
echo "==========================================="
sfdx config:set defaultusername="$ORG_ALIAS"
echo "✅ Default org set to: $ORG_ALIAS"
echo ""

# Step 3: Verify Connection
echo "Step 3: Verifying Connection"
echo "==========================================="
sfdx force:org:display --targetusername="$ORG_ALIAS"
echo ""

# Step 4: Deploy Project
echo "Step 4: Deploying Project to Salesforce"
echo "==========================================="
read -p "Deploy now? (y/n): " DEPLOY

if [ "$DEPLOY" = "y" ]; then
    echo "⏳ Deploying source to $ORG_ALIAS..."
    sfdx force:source:push --verbose --targetusername="$ORG_ALIAS"
    
    if [ $? -eq 0 ]; then
        echo "✅ Deployment successful!"
    else
        echo "⚠️  Deployment had issues. Check the output above."
    fi
else
    echo "ℹ️  Skipped deployment. To deploy later, run:"
    echo "   sfdx force:source:push --targetusername=$ORG_ALIAS"
fi

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "1. Open your org: sfdx force:org:open --targetusername=$ORG_ALIAS"
echo "2. Check custom objects in Setup > Object Manager"
echo "3. Create new Lightning App for support team"
echo ""
