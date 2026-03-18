# 🚀 Setup Guide: GitHub & Vercel Deployment

## Step 1: Prepare for GitHub

### Local Setup (Already Done ✓)
- [x] Next.js project created
- [x] API endpoints built
- [x] MongoDB models configured
- [x] React components created
- [x] `.gitignore` configured
- [x] Environment template created

### Next Steps:

1. **Initialize Git Repository** (if not already done)
```bash
cd c:\Users\sudho\Desktop\Customer-Support-AI
git init
git add .
git commit -m "Initial commit: Web app conversion from Salesforce"
```

2. **Create GitHub Repository**
   - Go to https://github.com/new
   - Repository name: `Customer-Support-AI`
   - Description: "AI-Powered Customer Support System"
   - Make it **Public** (required for Vercel free tier)
   - Don't initialize README (we already have one)
   - Click "Create repository"

3. **Push to GitHub**
```bash
git remote add origin https://github.com/sud-git/Customer-Support-AI.git
git branch -M main
git push -u origin main
```

---

## Step 2: Set Up MongoDB Atlas

### Create Free MongoDB Cluster

1. Go to https://www.mongodb.com/cloud/atlas
2. Sign up or log in
3. Create a new project named "customer-support-ai"
4. Create a M0 (free) cluster
5. Create a database user:
   - Username: `dev_user`
   - Password: Generate a strong password
   - Click "Create User"
6. Add your IP address to the whitelist (or allow all: `0.0.0.0/0`)
7. Click "Databases" → "Connect" → "Drivers"
8. Copy the connection string

### Format Your Connection String
Replace placeholders:
```
mongodb+srv://dev_user:YOUR_PASSWORD@cluster0.xxxxx.mongodb.net/customer_support?retryWrites=true&w=majority
```

---

## Step 3: Deploy on Vercel

### Connect GitHub to Vercel

1. Go to https://vercel.com
2. Click "New Project"
3. Click "Import Git Repository"
4. Paste: `https://github.com/sud-git/Customer-Support-AI`
5. Click "Import"

### Configure Environment Variables

In Vercel dashboard:
1. Go to Settings → Environment Variables
2. Add the following:

| Variable | Value |
|----------|-------|
| `MONGODB_URI` | Your MongoDB connection string |
| `NEXT_PUBLIC_API_URL` | `https://your-app.vercel.app` |

3. Click "Save"

### Deploy

1. Click "Deploy"
2. Wait for build to complete (2-5 minutes)
3. Your app is now live! 🎉

---

## Step 4: Verify Deployment

1. Open your Vercel app URL
2. Test these features:
   - Dashboard loads
   - Navigate to Customers page
   - Try creating a customer
   - Check Orders, Cases, etc.

### Troubleshooting Deployment

```bash
# Check build logs in Vercel → Deployments → Build Logs

# Common issues:
# - "Cannot find module": npm install not running
#   Fix: Vercel should auto-run, check Project Settings → Build & Output

# - "MongoDB connection failed": Check MONGODB_URI
#   Fix: Verify string in Vercel Environment Variables

# - "PORT already in use": Vercel assigns PORT automatically
#   Fix: Use process.env.PORT in next.config.js
```

---

## Step 5: Continuous Deployment

Every time you push to GitHub:
1. Vercel automatically detects changes
2. Builds your app
3. Deploys to `your-app.vercel.app`

### Make Changes Locally

```bash
# Make code changes
git add .
git commit -m "Feature: Add new functionality"
git push origin main

# Vercel automatically deploys! ✅
```

---

## Step 6: Add Sample Data (Optional)

To populate your database with test data:

1. Use MongoDB Atlas Web Console:
   - Go to Atlas → Collections
   - Insert sample documents

2. Or create a data import script:
```javascript
// scripts/import-data.js
import mongoose from 'mongoose';
import Customer from '@/models/Customer';
import Merchandise from '@/models/Merchandise';

const sampleCustomers = [
  { name: 'John Doe', email: 'john@example.com', status: 'Active' },
  { name: 'Jane Smith', email: 'jane@example.com', status: 'Active' },
];

async function importData() {
  await mongoose.connect(process.env.MONGODB_URI);
  await Customer.insertMany(sampleCustomers);
  console.log('Data imported!');
}

importData();
```

---

## Step 7: Custom Domain (Optional)

Add your own domain to Vercel:

1. Go to Vercel → Settings → Domains
2. Enter your domain
3. Update DNS records (Vercel will show instructions)
4. Wait 24h for DNS propagation

---

## 📊 Final Checklist

- [ ] Git repository initialized locally
- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] MongoDB Atlas cluster created
- [ ] MongoDB user created with connection string
- [ ] Vercel project created and connected to GitHub
- [ ] Environment variables set in Vercel
- [ ] App deployed successfully
- [ ] Tested all pages and API endpoints
- [ ] Sample data added (optional)

---

## 🆘 Support

- **Next.js Issues**: https://github.com/vercel/next.js/discussions
- **MongoDB Help**: https://docs.mongodb.com
- **Vercel Docs**: https://vercel.com/docs
- **Deployment FAQ**: https://vercel.com/docs/platform/frequently-asked-questions

---

## 🎉 You're Ready!

Your app is now:
- ✅ Version controlled on GitHub
- ✅ Deployed on Vercel (auto-scaling)
- ✅ Connected to MongoDB (cloud database)
- ✅ Ready for production use

**Next steps:**
1. Share your Vercel URL with others
2. Add more features as needed
3. Monitor performance in Vercel analytics
4. Scale as your user base grows!
