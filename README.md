# 🚀 Customer Support AI - Full Stack Web Application

> **🎉 Now deployed as a modern web app!**  
> Converted from Salesforce to **Next.js + MongoDB** with one-click deployment on Vercel.

**Live Demo:** [Deploy to Vercel](https://vercel.com/new/git/external?repository-url=https%3A%2F%2Fgithub.com%2Fsud-git%2FCustomer-Support-AI)

## 📊 Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | ⚡ Next.js 14, React 18, Tailwind CSS |
| **Backend** | 🟢 Node.js, Next.js API Routes |
| **Database** | 🍃 MongoDB, Mongoose ODM |
| **Hosting** | 🔷 Vercel (Serverless) |
| **Version Control** | 🐙 GitHub |

## ✨ Features

- **📊 Dashboard** - Real-time analytics and statistics
- **👥 Customer Management** - CRUD operations with full tracking
- **📦 Order Management** - Order lifecycle and status tracking
- **🎫 Support Tickets** - Case management with priority levels
- **📚 Knowledge Base** - Article management and search
- **🛍️ Product Catalog** - Inventory and merchandise management
- **🔍 Quality Inspections** - Inspection reports with scoring
- **⚡ RESTful API** - Full CRUD endpoints for all modules
- **🔐 Secure** - Environment variables, validation, CORS-ready
- **🌐 Global Scale** - CDN, auto-scaling, high availability

## 📁 Project Structure

```
Customer-Support-AI/
├── 📁 app/                         # Next.js App Directory
│   ├── 📁 api/                     # API Routes (Backend)
│   │   ├── customers/route.js      # Customer CRUD API
│   │   ├── orders/route.js         # Order CRUD API
│   │   ├── cases/route.js          # Case CRUD API
│   │   ├── merchandise/route.js    # Product CRUD API
│   │   ├── knowledge/route.js      # Knowledge CRUD API
│   │   └── inspections/route.js    # Inspection CRUD API
│   ├── 📁 dashboard/               # Dashboard page
│   ├── 📁 customers/               # Customers page
│   ├── 📁 orders/                  # Orders page
│   ├── 📁 cases/                   # Cases page
│   ├── 📁 merchandise/             # Products page
│   ├── 📁 knowledge/               # Knowledge base page
│   ├── 📁 inspections/             # Inspections page
│   ├── layout.js                   # Root layout + navigation
│   ├── page.js                     # Home page
│   └── globals.css                 # Global styles
├── 📁 models/                      # MongoDB Mongoose Models
│   ├── Customer.js
│   ├── Order.js
│   ├── Case.js
│   ├── Merchandise.js
│   ├── Knowledge.js
│   └── Inspection.js
├── 📁 lib/
│   └── db.js                       # MongoDB Connection
├── 📁 public/                      # Static Assets
├── 📁 data/                        # Sample Data (CSV)
├── 📁 docs/                        # Documentation
├── 📁 scripts/                     # Setup Scripts
├── 📄 package.json                 # Dependencies
├── 📄 next.config.js               # Next.js Config
├── 📄 tailwind.config.js           # Tailwind Config
├── 📄 vercel.json                  # Vercel Config
├── 📄 .env.local.example           # Environment Template
└── 📄 README.md                    # This File
```

## 🚀 Quick Start (5 Minutes)

### Option 1: Deploy to Vercel (Recommended)

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/git/external?repository-url=https%3A%2F%2Fgithub.com%2Fsud-git%2FCustomer-Support-AI)

**Steps:**
1. Click the button above
2. Create/connect your GitHub account
3. Add `MONGODB_URI` environment variable
4. Click "Deploy"
5. Your app is live! 🎉

📖 **Full guide:** See [QUICK_START_DEPLOY.md](QUICK_START_DEPLOY.md)

### Option 2: Run Locally

#### Prerequisites

- **Node.js** 18+ - [Download](https://nodejs.org/)
- **MongoDB** - [Get free cluster](https://www.mongodb.com/cloud/atlas)
- **Git** - [Download](https://git-scm.com/)

#### Installation

```bash
# Clone the repository
git clone https://github.com/sud-git/Customer-Support-AI.git
cd Customer-Support-AI

# Install dependencies
npm install

# Create environment file
cp .env.local.example .env.local

# Edit .env.local and add your MongoDB URI
# MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/database

# Start development server
npm run dev
```

Open **[http://localhost:3000](http://localhost:3000)** in your browser! 🚀

## 📚 Documentation

| Document | Purpose |
|----------|---------|
| [WEB_APP_README.md](WEB_APP_README.md) | 📖 Complete application guide & API docs |
| [QUICK_START_DEPLOY.md](QUICK_START_DEPLOY.md) | ⚡ 30-minute deployment guide |
| [GITHUB_VERCEL_SETUP.md](GITHUB_VERCEL_SETUP.md) | 📋 Step-by-step setup instructions |
| [WEB_APP_DEPLOYMENT_COMPLETE.md](WEB_APP_DEPLOYMENT_COMPLETE.md) | ✅ Completion summary & roadmap |

## 🔌 API Endpoints

All endpoints are **production-ready** with full CRUD operations:

### Customers
```
GET    /api/customers              # List all customers
POST   /api/customers              # Create customer
PUT    /api/customers?id=<id>      # Update customer
DELETE /api/customers?id=<id>      # Delete customer
```

### Orders
```
GET    /api/orders                 # List all orders
POST   /api/orders                 # Create order
PUT    /api/orders?id=<id>         # Update order
DELETE /api/orders?id=<id>         # Delete order
```

### Support Cases
```
GET    /api/cases                  # List all cases
POST   /api/cases                  # Create case
PUT    /api/cases?id=<id>          # Update case
DELETE /api/cases?id=<id>          # Delete case
```

### Products / Merchandise
```
GET    /api/merchandise            # List all products
POST   /api/merchandise            # Create product
PUT    /api/merchandise?id=<id>    # Update product
DELETE /api/merchandise?id=<id>    # Delete product
```

### Knowledge Base
```
GET    /api/knowledge              # List published articles
POST   /api/knowledge              # Create article
PUT    /api/knowledge?id=<id>      # Update article
DELETE /api/knowledge?id=<id>      # Delete article
```

### Inspections
```
GET    /api/inspections            # List inspections
POST   /api/inspections            # Create inspection
PUT    /api/inspections?id=<id>    # Update inspection
DELETE /api/inspections?id=<id>    # Delete inspection
```

## 🛠️ Available Scripts

```bash
npm run dev      # Start development server (port 3000)
npm run build    # Build for production
npm start        # Start production server
npm run lint     # Run ESLint checks
```

## 🌍 Deployment Options

| Platform | Cost | Setup Time |
|----------|------|-----------|
| **Vercel** | Free tier available | 10 minutes |
| **Railway** | Free tier available | 15 minutes |
| **Render** | Free tier available | 15 minutes |
| **AWS** | Pay per use | 20 minutes |
| **Azure** | Free tier available | 20 minutes |

**Recommended:** [Vercel](https://vercel.com) - Optimized for Next.js, global CDN, auto-deployments.

## 📊 MongoDB Setup

### Free Tier (MongoDB Atlas)

1. **Sign up:** https://www.mongodb.com/cloud/atlas
2. **Create cluster:** M0 (free tier)
3. **Create user:** Database credentials
4. **Get URI:** Connection string
5. **Use URI:** Paste in `.env.local`

```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/database?retryWrites=true&w=majority
```

## 🔐 Environment Variables

Create `.env.local` in project root:

```env
# Required
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/database?retryWrites=true&w=majority

# Optional
NEXT_PUBLIC_API_URL=http://localhost:3000
NODE_ENV=development
```

## 📦 Features & Modules

### 1. Dashboard
- Real-time statistics
- Quick navigation
- System overview

### 2. Customer Management
- Create/edit customer profiles
- Contact information tracking
- Customer status management
- Full history

### 3. Order Management  
- Complete order lifecycle
- Item tracking
- Shipping information
- Status updates

### 4. Support Tickets
- Case creation & resolution
- Priority assignment
- Knowledge base linking


## 🧪 Testing API Locally

### Using cURL

```bash
# Get all customers
curl http://localhost:3000/api/customers

# Create a customer
curl -X POST http://localhost:3000/api/customers \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "555-1234",
    "status": "Active"
  }'

# Get single customer
curl http://localhost:3000/api/customers?id=CUSTOMER_ID

# Update customer
curl -X PUT http://localhost:3000/api/customers?id=CUSTOMER_ID \
  -H "Content-Type: application/json" \
  -d '{"status": "Inactive"}'

# Delete customer
curl -X DELETE http://localhost:3000/api/customers?id=CUSTOMER_ID
```

### Using Postman

1. Import the API into [Postman](https://www.postman.com/)
2. Set `{{MONGODB_ID}}` variables in your environment
3. Test each endpoint
4. Save your collection for team sharing

## 🚀 Continuous Integration & Deployment

### Auto-Deploy with Vercel

Every push to `main` branch automatically:
1. Builds your application
2. Runs tests
3. Deploys to production
4. Shows build status

No manual steps needed! ✨

### Manual Deployment

```bash
# Build locally
npm run build

# Start production server
npm start

# Test production build locally
# Should be similar to deployment
```

## 🔧 Development Workflow

### Adding a New Feature

1. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes**
   - Update models if needed
   - Create/modify API routes
   - Add/update components

3. **Test locally**
   ```bash
   npm run dev
   # Visit http://localhost:3000
   ```

4. **Commit and push**
   ```bash
   git add .
   git commit -m "feature: Add your feature description"
   git push origin feature/your-feature-name
   ```

5. **Create Pull Request on GitHub**
   - Describe your changes
   - Link related issues
   - Request review

6. **Merge to main**
   - Code review approved
   - Vercel auto-deploys

### Code Style

- Use **Prettier** for formatting
- Follow **React best practices**
- Use **functional components**
- Keep API routes simple and focused

## 🐛 Troubleshooting

### "Cannot connect to MongoDB"
```
✓ Check MONGODB_URI in .env.local
✓ Verify connection string format
✓ Whitelist your IP in MongoDB Atlas
✓ Restart development server
```

### "Port 3000 already in use"
```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# macOS/Linux
lsof -ti:3000 | xargs kill -9
```

### "npm install fails"
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and lock file
rm -rf node_modules package-lock.json

# Reinstall
npm install
```

### "Vercel deployment fails"
- Check build logs in Vercel dashboard
- Verify all environment variables are set
- Run `npm run build` locally to test

### "API returns 500 error"
- Check MongoDB connection
- View server logs in terminal
- Verify data format matches schema

## 📚 Learning Resources

### Next.js
- [Next.js Official Docs](https://nextjs.org/docs)
- [React Patterns](https://reactpatterns.com/)
- [Next.js API Routes](https://nextjs.org/docs/api-routes/introduction)

### MongoDB & Mongoose
- [MongoDB Documentation](https://docs.mongodb.com/)
- [Mongoose Guide](https://mongoosejs.com/docs/guide.html)
- [MongoDB Atlas](https://www.mongodb.com/cloud/atlas/register)

### Tailwind CSS
- [Tailwind CSS Docs](https://tailwindcss.com/docs)
- [Component Library](https://tailwindui.com/)
- [Utility Classes](https://tailwindcss.com/docs/utility-first)

### Vercel
- [Vercel Docs](https://vercel.com/docs)
- [Deployment Guide](https://vercel.com/docs/concepts/deployments/overview)
- [Environment Variables](https://vercel.com/docs/concepts/projects/environment-variables)

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Commit your changes** (`git commit -m 'Add amazing feature'`)
4. **Push to the branch** (`git push origin feature/amazing-feature`)
5. **Open a Pull Request**

## 📞 Support

- **Documentation:** Check guides in repository
- **Issues:** [GitHub Issues](https://github.com/sud-git/Customer-Support-AI/issues)
- **Discussions:** [GitHub Discussions](https://github.com/sud-git/Customer-Support-AI/discussions)

## 📄 License

MIT License - feel free to use this project for personal or commercial purposes.

## 🎯 Roadmap

- [ ] Authentication & user roles
- [ ] Email notifications
- [ ] PDF report generation
- [ ] Advanced search & filtering
- [ ] Real-time updates with WebSockets
- [ ] Mobile app (React Native)
- [ ] Admin analytics dashboard
- [ ] AI chat integration
- [ ] Multi-language support
- [ ] Dark mode

## ✨ Acknowledgments

- Built with [Next.js](https://nextjs.org/)
- Styled with [Tailwind CSS](https://tailwindcss.com/)
- Database powered by [MongoDB](https://www.mongodb.com/)
- Deployed on [Vercel](https://vercel.com/)

---

**Made with ❤️ by the Customer Support AI Team**

⭐ If you find this project helpful, please star it on GitHub!

   - Approval workflow access
   - Report generation

3. **Admin**
   - Full system access

---

## 📊 Sample Data

Sample data files are provided in `/data` folder:
- `customers.csv` - 10 sample customers
- `merchandise.csv` - 20 sample products
- `orders.csv` - 25 sample orders
- `cases.csv` - 15 sample support cases

### Load Sample Data

```bash
# Using SFDX data import
sfdx force:data:tree:import --plan ./data/data-plan.json --targetusername=MyOrg
```

---

## 🧪 Testing

### Run Apex Tests

```bash
sfdx force:apex:test:run --targetusername=MyOrg --resultformat=json
```

### Run Jest Tests (if applicable)

```bash
npm test
```

---

## 📚 Additional Resources

- [Salesforce Developer Documentation](https://developer.salesforce.com/docs)
- [Agentforce Setup Guide](https://help.salesforce.com/s/articleView?id=sf.agentforce_setup.htm)
- [Prompt Builder Guide](https://help.salesforce.com/s/articleView?id=sf.prompt_builder.htm)
- [SFDX CLI Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/)

---

## 🤝 Contributing

To contribute to this project:

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request

---

## 📄 License

MIT License - See LICENSE file for details

---

## ❓ Troubleshooting

### Issue: "INVALID_TYPE: must be a recognized custom object type"

**Solution:** Ensure object API names end with `__c` and are properly defined in metadata files.

### Issue: "Deploy failed - Invalid field relationship"

**Solution:** Verify all lookup/master-detail references use correct object API names.

### Issue: SFDX command not found

**Solution:** Install Salesforce CLI:
```bash
npm install -g @salesforce/cli
```

---

## 📞 Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review [Additional Resources](#additional-resources)
3. Open an issue in the project repository

---

**Last Updated:** March 18, 2026  
**Version:** 1.0.0  
**Status:** 🟡 In Progress (Phase 2, Step 1)
