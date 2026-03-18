# 🔐 Solution 2: Deploy Using Security Token

## Step-by-Step Guide to Generate Token & Deploy

---

## ✅ Step 1: Log Into Your Salesforce Org

1. Go to: **https://login.salesforce.com**
2. Log in with:
   - **Email:** `sud.holics123@gmail.com`
   - **Password:** (your Salesforce password)
3. Click **Login**

---

## ✅ Step 2: Generate Security Token

### Navigate to Security Token:

1. Click your **profile icon** (top right corner)
2. Click **Settings** (or **My Settings**)
3. On the left sidebar, search for: **"security token"** or navigate to:
   - **Personal Setup → Security → Security Token**

### Generate the Token:

1. Click **Reset Security Token** button
2. Check your email (usually takes 1-2 minutes)
3. Copy the security token from the email (long random string)
4. **Keep this token safe!** You'll need it next

---

## ✅ Step 3: Configure Salesforce CLI with Token

Once you have your security token, run this command in PowerShell:

```powershell
sf org login web --set-default-dev-hub --alias DevHub
```

When the browser window opens:
1. **Log in with your email:** `sud.holics123@gmail.com`
2. **For password field:** Enter: `[your-salesforce-password][security-token]`
   - Example: If your password is `MyPass123` and token is `abc123xyz`, enter: `MyPass123abc123xyz`
3. Click **Login**
4. **Click "Allow"** to authorize Salesforce CLI

---

## ✅ Step 4: Verify Authorization

Run this command to verify the connection:

```powershell
sf org list
```

You should see something like:
```
ALIAS    USERNAME                  LOGIN URL
─────────────────────────────────────────────────
DevHub   sud.holics123@gmail.com   https://login.salesforce.com
```

---

## ✅ Step 5: Deploy Your Project

Once authorized, deploy all your code with:

```powershell
cd c:\Users\sudho\Desktop\Customer-Support-AI

# Deploy all custom objects, Apex, and metadata
sf project deploy start --target-org DevHub
```

**Wait for deployment to complete** (usually 2-3 minutes)

You should see:
```
✅ Deployment successful!
6 objects created
3 classes deployed
2 triggers created
```

---

## ✅ Step 6: Import Sample Data

### Download Sample Data:

Your CSV files are in the `data/` folder:
- `data/customers.csv`
- `data/merchandise.csv`
- `data/orders.csv`
- `data/cases.csv`

### Import via Salesforce UI:

1. **In your Salesforce org**, go to:
   - **Setup (⚙️ icon) → Data Import & Export → Data Import**

2. **Click "Launch the Data Import Wizard"**

3. **For each CSV file** (in this order):

   **Import 1 - Customers:**
   - Upload: `customers.csv`
   - Select Standard Objects: **Customer__c**
   - Click **Next** → **Start Import**

   **Import 2 - Merchandise:**
   - Upload: `merchandise.csv`
   - Select Standard Objects: **Merchandise__c**
   - Click **Next** → **Start Import**

   **Import 3 - Orders:**
   - Upload: `orders.csv`
   - Select Standard Objects: **Order__c**
   - Click **Next** → **Start Import**

   **Import 4 - Cases:**
   - Upload: `cases.csv`
   - Select Standard Objects: **Case__c**
   - Click **Next** → **Start Import**

---

## ✅ Step 7: Verify Deployment

### Check Custom Objects:

1. Go to **Setup → Object Manager**
2. You should see all 6 objects:
   - ✅ Customer__c
   - ✅ Merchandise__c
   - ✅ Order__c
   - ✅ Case__c
   - ✅ Knowledge__c
   - ✅ Inspection__c

### Check Apex Code:

1. Click your **profile icon** → **Developer Console**
2. Go to **File → Open Entity**
3. Under **Apex Classes**, you should see:
   - ✅ CaseAutoResponder
   - ✅ InspectionSummaryService
   - ✅ CustomerSupportUtility

### Check Sample Data:

1. In your Salesforce org, click the **app launcher** (grid icon)
2. Search for **"Customer"**
3. Click **Customers**
4. You should see **10 customer records**

---

## 🚀 If Deployment Fails

### Issue: "Invalid OAuth login"
**Solution:** Make sure you're using the correct password + token combination:
```
[Salesforce Password][Security Token]
```

### Issue: "Port already in use"
**Solution:** Change the OAuth port in `sfdx-project.json`:
```json
{
  "oauthLocalPort": 3030
}
```

### Issue: "Deployment timeout"
**Solution:** Run deployment again with verbose output:
```powershell
sf project deploy start --target-org DevHub --verbose
```

---

## 📋 Deployment Checklist

- [ ] Generated security token from email
- [ ] Run `sf org login web --alias DevHub`
- [ ] Combined password + token for login
- [ ] Run `sf org list` to verify connection
- [ ] Run `sf project deploy start --target-org DevHub`
- [ ] Verified all 6 objects are created
- [ ] Verified all 3 classes are deployed
- [ ] Imported 4 CSV files with sample data
- [ ] Can see customer records in Salesforce

---

## ✅ You're Done!

Your complete Salesforce AI Customer Support System is now deployed and ready to use!

**Next Steps:**
1. Create Lightning pages to display the data
2. Set up Flows for case routing automation
3. Configure Permission Sets for team members
4. Create Agentforce skills with your Prompts
5. Deploy to Production when ready

---

**Questions?** Check:
- [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) - Full SFDX documentation
- [ARCHITECTURE.md](docs/ARCHITECTURE.md) - System design
- [FIELDS_REFERENCE.md](docs/FIELDS_REFERENCE.md) - All field specifications

