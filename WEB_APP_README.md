# 🚀 Customer Support AI - Web Application

A modern, full-stack web application for AI-powered customer support and service automation. Built with Next.js, React, MongoDB, and Tailwind CSS. Ready to deploy on Vercel.

## ✨ Features

- 📊 **Dashboard** - Real-time metrics and overview
- 👥 **Customer Management** - Manage customer profiles and relationships
- 📦 **Order Management** - Track orders and shipments
- 🎫 **Support Tickets** - Handle customer support cases
- 📚 **Knowledge Base** - Build and search support articles
- 🛍️ **Merchandise Catalog** - Manage products and inventory
- 🔍 **Quality Inspections** - Track inspection reports and quality scores
- 🔐 **REST API** - Full CRUD operations for all modules

## 🛠️ Tech Stack

- **Frontend:** Next.js 14, React 18, Tailwind CSS
- **Backend:** Next.js API Routes, Node.js
- **Database:** MongoDB
- **Deployment:** Vercel
- **Version Control:** Git & GitHub

## 📋 Prerequisites

- Node.js 18+
- MongoDB Atlas account (free: https://www.mongodb.com/cloud/atlas)
- GitHub account
- Vercel account (free: https://vercel.com)

## 🚀 Quick Start

### 1. Clone the Repository

\`\`\`bash
git clone https://github.com/sud-git/Customer-Support-AI.git
cd Customer-Support-AI
\`\`\`

### 2. Install Dependencies

\`\`\`bash
npm install
\`\`\`

### 3. Set Up Environment Variables

Create a \`.env.local\` file in the root directory:

\`\`\`env
MONGODB_URI=mongodb+srv://<username>:<password>@<cluster>.mongodb.net/<database>?retryWrites=true&w=majority
NEXT_PUBLIC_API_URL=http://localhost:3000
NODE_ENV=development
\`\`\`

**MongoDB Atlas Setup:**
1. Go to https://www.mongodb.com/cloud/atlas
2. Create a free cluster
3. Create a database user
4. Get your connection string
5. Replace `<username>`, `<password>`, `<cluster>`, and `<database>` in the URI

### 4. Run Development Server

\`\`\`bash
npm run dev
\`\`\`

Open [http://localhost:3000](http://localhost:3000) in your browser.

## 📁 Project Structure

\`\`\`
├── app/
│   ├── api/                    # API Routes (CRUD operations)
│   │   ├── customers/
│   │   ├── orders/
│   │   ├── cases/
│   │   ├── merchandise/
│   │   ├── knowledge/
│   │   └── inspections/
│   ├── dashboard/              # Dashboard page
│   ├── customers/              # Customer list page
│   ├── orders/                 # Orders page
│   ├── cases/                  # Support cases page
│   ├── merchandise/            # Products page
│   ├── knowledge/              # Knowledge base page
│   ├── inspections/            # Inspections page
│   ├── layout.js               # Root layout
│   ├── page.js                 # Home page
│   └── globals.css             # Global styles
├── models/                     # MongoDB Mongoose models
│   ├── Customer.js
│   ├── Order.js
│   ├── Case.js
│   ├── Merchandise.js
│   ├── Knowledge.js
│   └── Inspection.js
├── lib/
│   └── db.js                   # MongoDB connection
├── utils/                      # Utility functions
├── public/                     # Static assets
├── next.config.js              # Next.js configuration
├── tailwind.config.js          # Tailwind CSS configuration
├── postcss.config.js           # PostCSS configuration
├── package.json                # Dependencies
└── .env.local                  # Environment variables (gitignored)
\`\`\`

## 🔌 API Endpoints

### Customers
- `GET /api/customers` - Get all customers
- `GET /api/customers?id=<id>` - Get single customer
- `POST /api/customers` - Create customer
- `PUT /api/customers?id=<id>` - Update customer
- `DELETE /api/customers?id=<id>` - Delete customer

### Orders
- `GET /api/orders` - Get all orders
- `POST /api/orders` - Create order
- `PUT /api/orders?id=<id>` - Update order
- `DELETE /api/orders?id=<id>` - Delete order

### Support Cases
- `GET /api/cases` - Get all cases
- `POST /api/cases` - Create case
- `PUT /api/cases?id=<id>` - Update case
- `DELETE /api/cases?id=<id>` - Delete case

### Products/Merchandise
- `GET /api/merchandise` - Get all products
- `POST /api/merchandise` - Create product
- `PUT /api/merchandise?id=<id>` - Update product
- `DELETE /api/merchandise?id=<id>` - Delete product

### Knowledge Base
- `GET /api/knowledge` - Get published articles
- `POST /api/knowledge` - Create article
- `PUT /api/knowledge?id=<id>` - Update article
- `DELETE /api/knowledge?id=<id>` - Delete article

### Inspections
- `GET /api/inspections` - Get all inspections
- `POST /api/inspections` - Create inspection
- `PUT /api/inspections?id=<id>` - Update inspection
- `DELETE /api/inspections?id=<id>` - Delete inspection

## 🚀 Deployment to Vercel

### Step 1: Push to GitHub

\`\`\`bash
git add .
git commit -m "Initial commit"
git push origin main
\`\`\`

### Step 2: Deploy on Vercel

1. Go to [https://vercel.com](https://vercel.com)
2. Click "New Project"
3. Import your GitHub repository
4. Set environment variables in Vercel:
   - \`MONGODB_URI\` = Your MongoDB connection string
   - \`NEXT_PUBLIC_API_URL\` = Your Vercel deployment URL
5. Click "Deploy"

### Step 3: Update Environment Variables

After deployment, update your \`.env.local\`:

\`\`\`env
NEXT_PUBLIC_API_URL=https://your-app.vercel.app
\`\`\`

## 📊 Sample Data

To populate the database with sample data:

\`\`\`bash
npm run import-data
\`\`\`

This will load data from the \`data/\` directory (CSV files from the original Salesforce project).

## 🔒 Security

- Environment variables are stored securely in Vercel
- MongoDB connection strings are never exposed to the client
- API routes validate all requests
- CORS headers should be configured for production

## 📝 Development

### Add a New Feature

1. Create a new API route in \`app/api/\`
2. Create a Mongoose model in \`models/\`
3. Create a page component in \`app/\`
4. Test locally, then push to GitHub
5. Vercel will auto-deploy

### Testing API Locally

Use curl or Postman:

\`\`\`bash
# Get all customers
curl http://localhost:3000/api/customers

# Create a customer
curl -X POST http://localhost:3000/api/customers \\
  -H "Content-Type: application/json" \\
  -d '{"name":"John Doe","email":"john@example.com"}'
\`\`\`

## 🐛 Troubleshooting

### "Cannot connect to MongoDB"
- Check your MongoDB connection string in \`.env.local\`
- Ensure MongoDB Atlas IP whitelist includes your computer
- Verify \`MONGODB_URI\` format

### "Vercel deployment fails"
- Check build logs in Vercel dashboard
- Ensure all environment variables are set
- Run \`npm install\` and \`npm run build\` locally to test

### "API not working"
- Check browser console for errors
- Verify MongoDB is running and accessible
- Check \`/app/api/\` routes for typos

## 📚 Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [MongoDB Documentation](https://docs.mongodb.com)
- [Vercel Deployment Guide](https://vercel.com/docs)
- [Tailwind CSS](https://tailwindcss.com)

## 📄 License

MIT

## 👤 Author

Created for AI-Powered Customer Support Automation

---

**Ready to deploy? Visit [Vercel](https://vercel.com) and start building!** 🚀
