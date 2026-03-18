# 🌐 Web-Based Salesforce Deployment Guide

## No CLI Required - Deploy Directly via Salesforce UI

---

## ✅ Step 1: Log Into Your Salesforce Developer Account

1. Go to: **https://login.salesforce.com**
2. Log in with: **sud.holics123@gmail.com**
3. Enter your password
4. You're now in your Salesforce Org

---

## ✅ Step 2: Download Your Project Files from GitHub

Your project is already on GitHub at:
👉 https://github.com/sud-git/Customer-Support-AI

### Option A: Download as ZIP (Easiest)
1. Click **Code** → **Download ZIP**
2. Extract the ZIP file to your computer
3. You now have all the Salesforce metadata files

### Option B: Clone via Git (Advanced)
```bash
git clone https://github.com/sud-git/Customer-Support-AI.git
```

---

## ✅ Step 3: Deploy Custom Objects via Salesforce Setup

### Create Custom Objects Manually:

1. In Salesforce, go to: **Setup (⚙️ icon) → Objects and Fields → Object Manager**

2. **For each custom object**, click **Create → Custom Object** and fill in:
   - **Label:** (e.g., "Customer", "Order", "Case", etc.)
   - **Plural Label:** (e.g., "Customers", "Orders", "Cases")
   - **Object Name:** (e.g., "Customer__c", "Order__c", "Case__c")
   - Click **Save**

3. **For each field**, click **Fields & Relationships → New** and add:
   - Field type (Text, Email, Currency, Picklist, etc.)
   - Field label and name
   - Required/Unique constraints
   - Click **Save**

---

## ✅ Step 4: Import Sample Data

1. Go to: **Setup → Data Import & Export → Data Import Wizard**

2. **Upload CSV files** in this order:
   ```
   1. customers.csv      → Customer__c
   2. merchandise.csv    → Merchandise__c  
   3. orders.csv         → Order__c
   4. cases.csv          → Case__c
   ```

3. Download your CSV files from:
   📁 `data/` folder in your GitHub repository

---

## ✅ Step 5: Deploy Apex Code

### Option A: Use Salesforce Developer Console (Web IDE)
1. Click your **profile icon** (top right) → **Developer Console**
2. File → New → **Apex Class**
3. Copy code from your GitHub:
   - `force-app/main/default/classes/CaseAutoResponder.cls`
   - `force-app/main/default/classes/InspectionSummaryService.cls`
   - `force-app/main/default/classes/CustomerSupportUtility.cls`
4. Paste each class and click **Save**

### Option B: Use VS Code with Salesforce Extension
See the **VS Code Setup** section below.

---

## ✅ Step 6: Create Triggers

1. In **Developer Console**:
   - File → New → **Apex Trigger**
   
2. Create trigger: **CaseTrigger**
   - Copy code from: `docs/triggers/CaseTrigger.trigger`
   
3. Create trigger: **InspectionTrigger**
   - Copy code from: `docs/triggers/InspectionTrigger.trigger`

---

## ✅ Step 7: Set Up Prompt Builder Templates

### Create AI Prompts:

1. Go to: **Setup → Agentforce → Prompt Builder**

2. **Create New Prompt** for each:
   - **GenerateCaseSummary**
   - **GenerateInspectionSummary**
   - **SuggestKnowledgeArticles**
   - **AnalyzeCustomerSentiment**
   - **DiagnoseOrderIssue**

3. Copy prompt content from:
   📄 `force-app/main/default/prompts/PROMPT_TEMPLATES.md`

4. Click **Save** for each prompt

---

## 🔧 VS Code Setup (Recommended Alternative)

### Install Salesforce Extension Pack:

1. Open **VS Code**
2. Go to **Extensions** (Ctrl+Shift+X)
3. Search for: **Salesforce Extensions for VS Code**
4. Install **Salesforce Extension Pack** (official from Salesforce)

### Authorize Your Org:

1. Press **Ctrl+Shift+P**
2. Search for: **SFDX: Authorize an Org**
3. Follow the browser prompts
4. Select **Production** or **Sandbox**
5. Authorize and done!

### Deploy with VS Code:

1. Right-click on `force-app` folder
2. Select **Deploy Source to Org**
3. Select your authorized org
4. Watch it deploy! ✅

---

## 📊 Manual Deployment Checklist

- [ ] Logged into Salesforce
- [ ] Downloaded project files from GitHub
- [ ] Created all 6 custom objects:
  - [ ] Customer__c
  - [ ] Merchandise__c
  - [ ] Order__c
  - [ ] Case__c
  - [ ] Knowledge__c
  - [ ] Inspection__c
- [ ] Added all 50+ fields to objects
- [ ] Imported sample data (4 CSV files)
- [ ] Created 3 Apex classes
- [ ] Created 2 Apex triggers
- [ ] Created 5 Prompt Builder templates
- [ ] Tested the system

---

## 🚀 Testing Your Deployment

1. **Check Custom Objects:**
   - Go to Setup → Objects and Fields → Object Manager
   - Verify all 6 objects are visible

2. **Check Apex Classes:**
   - Developer Console → File → Open Entity
   - Verify all 3 classes are present

3. **Check Sample Data:**
   - Click on "Customer" tab
   - Should see 10 customer records

4. **Test a Trigger:**
   - Create a new Case record
   - Should see CaseTrigger fire

---

## ⚠️ Troubleshooting

### Objects not showing up?
- Make sure Status = "Active"
- Refresh the page
- Check Object Manager again

### Apex Classes have errors?
- Check syntax in Developer Console
- Copy the exact code from GitHub
- Make sure all dependencies are created first

### Data import fails?
- Make sure CSV is in correct format
- Check field mappings before importing
- Import in correct order (Customer → Order → etc.)

### Prompts not working?
- Make sure Agentforce is enabled in your org
- Check prompt syntax in Prompt Builder
- Verify all required fields are filled

---

## 📞 Need Help?

1. Check the [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for detailed SFDX commands
2. Check [ARCHITECTURE.md](docs/ARCHITECTURE.md) for system design
3. Check [FIELDS_REFERENCE.md](docs/FIELDS_REFERENCE.md) for all field specs

---

## ✅ You're Done!

Once all steps are complete, your AI-Powered Customer Support System is live on Salesforce!

**Next steps:**
1. Create Lightning App to display data
2. Set up Flows for automation
3. Configure Permission Sets for users
4. Deploy to production org when ready

---

**Happy deploying! 🎉**
