# STEP 7: Complete Execution & Deployment Guide

## 🚀 QUICK START - Command Checklist

### Prerequisites Check (Run First)
```powershell
# Verify SFDX is installed
sfdx --version

# Verify Node.js is installed  
node --version

# Verify you're in the correct project directory
pwd
# Should output: c:\Users\sudho\Desktop\Customer-Support-AI
```

---

## 📋 DEPLOYMENT WORKFLOW

### Phase 1: Org Authorization (5 minutes)

#### For Developer/Sandbox Org:
```powershell
# Authenticate with Salesforce
sfdx force:auth:web:login --setalias MyOrg --instanceurl https://login.salesforce.com

# For Sandbox:
sfdx force:auth:web:login --setalias MySandbox --instanceurl https://test.salesforce.com
```

**What happens:**
- Browser opens to Salesforce login
- Approve access in your browser
- Connection established to your org
- Credentials stored locally in `.sfdx/` folder

#### Set Default Org:
```powershell
sfdx config:set defaultusername=MyOrg
```

#### Verify Connection:
```powershell
sfdx force:org:display --targetusername=MyOrg
```

**Expected output:**
```
Username: your-email@example.com
Org ID: 00D... (18-character ID)
Connected Status: Connected
```

---

### Phase 2: Validate Project Structure (2 minutes)

```powershell
# Validate sfdx-project.json syntax
sfdx force:source:status --targetusername=MyOrg

# Should show custom objects ready to deploy:
# - Customer__c
# - Merchandise__c
# - Order__c
# - Case__c
# - Knowledge__c
# - Inspection__c
```

---

### Phase 3: Deploy Custom Objects (10 minutes)

#### Deploy All Source Code:
```powershell
# Push all metadata to org
sfdx force:source:push --targetusername=MyOrg --verbose

# Expected output: Successfully pushed source to org
# Component Failures: 0
# Created: 6 custom objects, 3 Apex classes
```

#### If deployment fails, check errors:
```powershell
# Get detailed deployment logs
sfdx force:source:pull --targetusername=MyOrg

# Check for syntax errors in objects or classes
sfdx force:source:status --targetusername=MyOrg
```

---

### Phase 4: Add Sample Data (15 minutes)

#### Load Customer Data:
```powershell
# Import customers
sfdx force:data:tree:import --sobjecttreefile data/data-plan.json --targetusername=MyOrg

# OR use CSV import (manual step via Salesforce UI):
# 1. Go to Setup → Data Import Wizard
# 2. Select "Customers (Customer__c)"
# 3. Upload data/customers.csv
# 4. Start import
```

#### Manual CSV Import Steps (Alternative):
```
Salesforce UI Steps:
1. Setup → Data Import Wizard
2. Choose "Standard objects" or custom objects
3. Select object from dropdown
4. Upload CSV file
5. Map fields:
   - Name → CustomerName__c
   - Email → CustomerEmail__c
   - Phone → CustomerPhone__c
   - City, State, Country → respective fields
   - Status → CustomerStatus__c
   - Type → CustomerType__c
6. Review and import
```

#### Data Import Order (Important):
```
1. ✅ Customers first
2. ✅ Merchandise 
3. ✅ Orders (depends on Customers)
4. ✅ Cases (depends on Customers)
5. ✅ Inspections (depends on Orders)
```

---

### Phase 5: Create Apex Triggers (5 minutes)

#### Create Case Trigger:
```
Salesforce UI Steps:
1. Setup → Object Manager → Case__c
2. Trigger → New
3. Name: CaseTrigger
4. Paste code from docs/triggers/CaseTrigger.trigger
5. Save
```

**CaseTrigger.trigger code:**
```apex
trigger CaseTrigger on Case__c (before insert, before update, after insert, after update) {
    if (Trigger.isInsert || Trigger.isUpdate) {
        CaseAutoResponder.handleCaseTrigger(
            Trigger.new,
            Trigger.old,
            Trigger.isInsert,
            Trigger.isUpdate
        );
    }
}
```

#### Create Inspection Trigger:
```
1. Setup → Object Manager → Inspection__c
2. Trigger → New
3. Name: InspectionTrigger
4. Paste code
```

**InspectionTrigger.trigger code:**
```apex
trigger InspectionTrigger on Inspection__c (before insert, before update) {
    InspectionSummaryService.handleInspectionTrigger(
        Trigger.new,
        Trigger.old,
        Trigger.isInsert,
        Trigger.isUpdate
    );
}
```

---

### Phase 6: Configure Prompt Builder (10 minutes)

#### Create Case Summary Prompt:
```
Salesforce UI Steps:
1. Setup → Prompt Builder
2. New Prompt
3. Name: GenerateCaseSummary
4. Model: Claude or GPT-4 (if configured)
5. Input Variables:
   - caseTitle (Text)
   - caseDescription (Text)
   - caseType (Text)
6. Paste prompt text from force-app/main/default/prompts/PROMPT_TEMPLATES.md
7. Save & Activate
8. Test with sample data
```

#### Create Inspection Summary Prompt:
```
1. Setup → Prompt Builder
2. Same process as above
3. Name: GenerateInspectionSummary
4. Use template from PROMPT_TEMPLATES.md
```

---

### Phase 7: Configure Agentforce (Ongoing)

#### Enable Agentforce:
```
Salesforce UI Steps:
1. Setup → Agentforce Settings
2. Enable Agentforce
3. Configure skills based on prompts:
   - Resolve Cases (uses GenerateCaseSummary)
   - Assess Quality (uses GenerateInspectionSummary)
   - Find Knowledge (uses SuggestKnowledgeArticles)
```

---

### Phase 8: Create Lightning App (15 minutes)

#### Create Lightning App:
```
Salesforce UI Steps:
1. Setup → App Manager
2. New Lightning App
3. Configure:
   - Name: Customer Support AI
   - Description: AI-powered support management
   - Logo: Upload logo (optional)
4. Add Pages:
   - Home
   - Cases list and detail
   - Customer list and detail
   - Orders list
   - Inspections list
5. Publish & deploy
```

---

### Phase 9: Set Permissions & Security (10 minutes)

#### Create Permission Set:
```
Salesforce UI Steps:
1. Setup → Permission Sets
2. New
3. Name: CustomerSupportAgent
4. Configure:
   - Object Permissions:
     • Customer__c: Create, Read, Update
     • Order__c: Create, Read, Update
     • Case__c: Create, Read, Update, Delete
     • Knowledge__c: Read
     • Inspection__c: Create, Read, Update
   - Apex Class Access:
     • CaseAutoResponder: Enabled
     • InspectionSummaryService: Enabled
     • CustomerSupportUtility: Enabled
5. Assign to users who need access
```

#### Assign Permission Set to Users:
```
Salesforce UI Steps:
1. Setup → Permission Sets → CustomerSupportAgent
2. Click "Manage Assignments"
3. Add Users → Select users
4. Assign
```

---

## 📊 DEPLOYMENT COMMANDS REFERENCE

### Status & Info Commands
```powershell
# Check deployment status
sfdx force:source:status --targetusername=MyOrg

# List all authenticated orgs
sfdx org:list

# Display org information
sfdx force:org:display --targetusername=MyOrg

# Show metadata details
sfdx force:mdapi:listmetadata --retrievetargetdir ./metadata --targetusername=MyOrg
```

### Push & Pull Commands
```powershell
# Push local changes to org
sfdx force:source:push --targetusername=MyOrg

# Pull changes from org
sfdx force:source:pull --targetusername=MyOrg

# Push with verbose output
sfdx force:source:push --verbose --targetusername=MyOrg --forceoverwrite

# Sync specific components
sfdx force:source:push --targetusername=MyOrg --sourcepath force-app/main/default/classes/
```

### Test Commands
```powershell
# Run all tests
sfdx force:apex:test:run --targetusername=MyOrg

# Run tests with coverage
sfdx force:apex:test:run --targetusername=MyOrg --codecoverage

# Run specific test class
sfdx force:apex:test:run --classnames CaseAutoResponder_Test --targetusername=MyOrg
```

### Data Commands
```powershell
# Query data using SOQL
sfdx force:data:soql:execute --query "SELECT Id, CustomerName__c FROM Customer__c LIMIT 10" --targetusername=MyOrg

# Export data
sfdx force:data:tree:export --query "SELECT Id, CustomerName__c, CustomerEmail__c FROM Customer__c" --outputdir ./exports --targetusername=MyOrg

# Import data
sfdx force:data:tree:import --sobjecttreefile ./data/data-plan.json --targetusername=MyOrg
```

### Org Management
```powershell
# Open org in browser
sfdx force:org:open --targetusername=MyOrg

# Set default username/org
sfdx config:set defaultusername=MyOrg

# Logout from org
sfdx force:auth:logout --targetusername=MyOrg
```

---

## ✅ POST-DEPLOYMENT VERIFICATION CHECKLIST

After deployment, verify everything is working:

### Custom Objects Created
```
Salesforce UI:
1. Setup → Object Manager
2. Verify these objects exist:
   ☐ Customer__c - with 10 fields
   ☐ Merchandise__c - with 9 fields
   ☐ Order__c - with 10 fields (linked to Customer)
   ☐ Case__c - with 10 fields (linked to Customer, Knowledge)
   ☐ Knowledge__c - with 8 fields
   ☐ Inspection__c - with 8 fields (linked to Order)
3. Click each object and verify fields are present
```

### Sample Data Imported
```
Salesforce UI:
1. App Launcher → Customer
2. Verify you see customer records
3. Repeat for:
   ☐ Customers: 10 records
   ☐ Merchandise: 20 products
   ☐ Orders: 15 orders
   ☐ Cases: 15 support cases
```

### Apex Classes Deployed
```
Salesforce UI:
1. Setup → Apex Classes
2. Verify these classes exist:
   ☐ CaseAutoResponder
   ☐ InspectionSummaryService
   ☐ CustomerSupportUtility
3. Classes should show "Active" status
```

### Lightning App Created
```
Salesforce UI:
1. App Launcher
2. Search for "Customer Support AI"
3. Verify app opens and shows:
   ☐ Customer tab
   ☐ Order tab
   ☐ Case tab
   ☐ Other configured pages
```

---

## 🆘 TROUBLESHOOTING

### Issue: "Component Deploy Failed: Invalid Field"

**Solution:**
```powershell
# Pull latest from org
sfdx force:source:pull --targetusername=MyOrg

# Check for conflicts in XML
# Review and fix the error message

# Try deployment again
sfdx force:source:push --targetusername=MyOrg
```

### Issue: "Deploy failed - Insufficient access or invalid cross-reference"

**Solution:**
```
1. Verify custom objects exist in org
2. Check field API names match exactly
3. Verify relationships (Master-Detail references)
4. Run: sfdx force:org:display to verify org connection
```

### Issue: "Entity is deleted" error

**Solution:**
```powershell
# This means a field/object was deleted elsewhere
# Pull changes first
sfdx force:source:pull --targetusername=MyOrg

# Review conflicts and merge
# Then push again
```

### Issue: "Apex test failures"

**Solution:**
```powershell
# Run tests with verbose output
sfdx force:apex:test:run --testlevel RunLocalTests --targetusername=MyOrg

# Check error messages and fix code
# Redeploy after fixes
```

### Issue: "Data import fails"

**Solution:**
1. Check CSV formatting (comma-separated, proper headers)
2. Verify field API names match CSV headers
3. Check data types (dates, currency, etc.)
4. Try importing one object at a time
5. Use Salesforce Data Import Wizard for troubleshooting

---

## 📈 POST-DEPLOYMENT NEXT STEPS

### 1. Configure Flows for Automation
```
Salesforce UI Steps:
1. Setup → Flows
2. Create flow "Case Auto-Response"
3. Trigger: On record create (Case__c)
4. Action: Call Apex class → CaseAutoResponder.processCaseSummaries
5. Activate
```

### 2. Set Up Dashboards
```
Salesforce UI:
1. Create dashboard "Support Metrics"
2. Add charts for:
   - Case volume by priority
   - Resolution time trends
   - Customer satisfaction
   - Inspection pass rate
```

### 3. Configure Reports
```
Salesforce UI:
1. App Launcher → Reports
2. Create custom reports for:
   - Open cases by agent
   - Order fulfillment metrics
   - Customer lifetime value
   - Quality inspection summary
```

### 4. Enable Agentforce
```
Salesforce UI:
1. Setup → Agentforce
2. Create custom skills linked to prompts
3. Configure conversation routing
4. Test with sample customer queries
```

---

## 🔄 CONTINUOUS DEPLOYMENT

### Update Workflow When Making Changes

```powershell
# 1. Pull latest changes from org
sfdx force:source:pull --targetusername=MyOrg

# 2. Make local modifications
# Edit files in VS Code

# 3. Validate changes
sfdx force:source:status --targetusername=MyOrg

# 4. Push to org
sfdx force:source:push --targetusername=MyOrg --verbose

# 5. Run tests
sfdx force:apex:test:run --targetusername=MyOrg

# 6. Verify in UI
```

---

## 📞 Getting Help

### Resources
- **Salesforce Docs:** https://developer.salesforce.com/docs
- **SFDX CLI Reference:** https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference
- **Prompt Builder Guide:** https://help.salesforce.com/s/articleView?id=sf.prompt_builder
- **Agentforce Guide:** https://help.salesforce.com/s/articleView?id=sf.agentforce_setup

### Verification Commands (Keep Handy)

```powershell
# All-in-One Deployment & Verification
sfdx force:auth:web:login --setalias MyOrg --instanceurl https://login.salesforce.com
sfdx config:set defaultusername=MyOrg
sfdx force:org:display --targetusername=MyOrg
sfdx force:source:push --verbose --targetusername=MyOrg
sfdx force:org:open --targetusername=MyOrg
```

---

## 📝 Final Checklist

```
✅ SFDX CLI installed and verified
✅ Salesforce org authenticated
✅ Project structure validated
✅ Custom objects deployed (6 objects)
✅ Apex classes deployed (3 classes)
✅ Sample data imported (4 types)
✅ Triggers created (2 triggers)
✅ Prompts configured (in Prompt Builder)
✅ Agentforce enabled
✅ Lightning app created
✅ Permission sets configured
✅ All objects verified in UI
✅ Sample data visible in records
✅ Flows automated
✅ Documentation reviewed
```

---

**🎉 DEPLOYMENT COMPLETE!**

Your AI-Powered Customer Support System is now live in Salesforce!

**Status:** Phase 2: Backend Configuration - 100% Complete  
**Next:** Phase 3: AI Setup (Agentforce fine-tuning)  
**Current Phase:** Production Ready

