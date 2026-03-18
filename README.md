# 🤖 AI-Powered Customer Support & Service Automation System

A comprehensive Salesforce solution for intelligent customer support, case management, and AI-driven automation using Agentforce and Prompt Builder.

## 📋 Project Overview

This project includes:

- **6 Custom Objects**: Customer, Merchandise, Order, Case, Knowledge, Inspection
- **AI Features**: Prompt Builder summaries, Agentforce support suggestions
- **Automation**: Flows, approvals, routing, notifications
- **UI**: Lightning App + Record Pages
- **Security**: Roles, Profiles, Field-Level Security
- **Apex Classes**: Utility classes for AI integration and automation

## 🏗️ Project Structure

```
Customer-Support-AI/
├── force-app/
│   └── main/
│       └── default/
│           ├── objects/              # Custom objects (Customer__c, Order__c, etc.)
│           ├── fields/               # Custom fields for each object
│           ├── layouts/              # Page layouts
│           ├── flows/                # Flow definitions
│           ├── classes/              # Apex classes
│           ├── prompts/              # Prompt Builder templates
│           ├── permissionsets/       # Permission sets
│           └── applications/         # Lightning App definitions
├── data/                             # Sample data (CSV/JSON)
├── docs/                             # Documentation
├── scripts/                          # Deployment scripts
├── sfdx-project.json                 # SFDX configuration
├── package.json                      # NPM configuration
├── .gitignore                        # Git ignore rules
└── README.md                         # This file
```

## 🚀 Quick Start

### Prerequisites

- **Salesforce CLI (SFDX)** - [Install here](https://developer.salesforce.com/tools/sfdxcli)
- **Node.js 18+** - [Install here](https://nodejs.org/)
- **VS Code** - [Install here](https://code.visualstudio.com/)
- **Salesforce Org** (Developer, Sandbox, or Production)

### Installation Steps

#### 1. Clone/Open This Project in VS Code

```bash
cd c:\Users\sudho\Desktop\Customer-Support-AI
code .
```

#### 2. Install Dependencies (Optional)

```bash
npm install
```

#### 3. Authorize Your Salesforce Org

```bash
sfdx force:auth:web:login --setalias MyOrg --instanceurl https://login.salesforce.com
```

**For Sandbox:**
```bash
sfdx force:auth:web:login --setalias MySandbox --instanceurl https://test.salesforce.com
```

#### 4. Set Default Org (Optional)

```bash
sfdx config:set defaultusername=MyOrg
```

#### 5. Verify Connection

```bash
sfdx force:org:display --targetusername=MyOrg
```

#### 6. Deploy Project to Salesforce

```bash
sfdx force:source:push --targetusername=MyOrg
```

#### 7. Open Salesforce Org

```bash
sfdx force:org:open --targetusername=MyOrg
```

---

## 📦 Phase Breakdown

### **Phase 1: Planning** ✅ (Completed)

- Project structure
- Object relationships
- Security model

### **Phase 2: Backend Configuration** (IN PROGRESS)

- [x] Step 1: Custom Objects
- [ ] Step 2: Validation Rules
- [ ] Step 3: Field Dependencies

**This Step 1 Includes:**
- Customer__c
- Merchandise__c
- Order__c
- Case__c
- Knowledge__c
- Inspection__c

### **Phase 3: AI Setup** (Upcoming)

- Prompt Builder templates
- Agentforce routing rules
- AI-powered summaries

### **Phase 4: Automation** (Upcoming)

- Flows for case routing
- Approval processes
- Notification workflows

### **Phase 5: UI Development** (Upcoming)

- Lightning App
- Record Pages
- Dashboards

### **Phase 6: Security & Testing** (Upcoming)

- Permission sets
- Role hierarchy
- Test data

### **Phase 7: Deployment** (Upcoming)

- Release management
- Org sync

---

## 📝 Naming Conventions

| Element | Pattern | Example |
|---------|---------|---------|
| Custom Object | `ObjectName__c` | `Customer__c` |
| Custom Field | `FieldName__c` | `CustomerName__c` |
| Relationship | `ObjectLink__c` | `CustomerLink__c` |
| Apex Class | `PascalCase` | `CaseAutoResponder` |
| Flow | `snake_case` | `case_auto_response_flow` |
| Permission Set | `PascalCase` | `CustomerSupportAgent` |

---

## 🔗 Object Relationships

```
Customer (Main)
├── ← Orders (1:M via Master-Detail)
└── ← Cases (1:M via Lookup)

Order
├── → Customer (Master-Detail)
└── ← Inspections (1:M via Master-Detail)

Case
├── → Customer (Lookup)
└── → Knowledge (Lookup)

Merchandise
└── (Standalone - referenced in Orders via Junction)

Inspection
└── → Order (Master-Detail)

Knowledge
└── (Standalone - linked to Cases)
```

---

## 📊 Key Fields by Object

### Customer__c
- `CustomerName__c` (Text, Required)
- `CustomerEmail__c` (Email, Required)
- `CustomerPhone__c` (Phone)
- `CustomerStatus__c` (Picklist: Active, Inactive, Suspended)
- `TotalOrders__c` (Number)
- `TotalSpend__c` (Currency)

### Merchandise__c
- `MerchandiseName__c` (Text, Required)
- `SKU__c` (Text, External ID, Unique)
- `Category__c` (Picklist)
- `Price__c` (Currency)
- `Stock__c` (Number)
- `IsActive__c` (Checkbox)

### Order__c
- `CustomerLink__c` (Master-Detail → Customer)
- `OrderDate__c` (Date)
- `OrderStatus__c` (Picklist: Pending, Processing, Shipped, Delivered, Cancelled)
- `TotalAmount__c` (Currency)
- `ShippingAddress__c` (Text Area)
- `TrackingNumber__c` (Text)

### Case__c
- `CustomerLink__c` (Lookup → Customer)
- `CaseTitle__c` (Text, Required)
- `CaseDescription__c` (Text Area, Required)
- `CaseType__c` (Picklist: Technical, Billing, Product, Complaint, Feature)
- `Priority__c` (Picklist: Low, Medium, High, Critical)
- `Status__c` (Picklist: New, In Progress, Waiting, Resolved, Closed)
- `AI_Summary__c` (Text Area - Generated by Prompt Builder)
- `AssignedAgent__c` (Lookup → User)
- `RelatedKnowledge__c` (Lookup → Knowledge)

### Knowledge__c
- `ArticleTitle__c` (Text, Required)
- `ArticleContent__c` (Long Text, Required)
- `Topic__c` (Picklist)
- `IsPublished__c` (Checkbox)

### Inspection__c
- `OrderLink__c` (Master-Detail → Order)
- `InspectionDate__c` (Date)
- `InspectionStatus__c` (Picklist: Passed, Failed, Pending)
- `QualityScore__c` (Number)
- `AI_Summary__c` (Text Area)
- `Comments__c` (Text Area)

---

## 🤖 AI Features

### Prompt Builder Templates

1. **Case Summary Generator**
   - Input: Case Description, Case Type
   - Output: Concise AI-generated summary + suggested resolution path

2. **Inspection Summary Generator**
   - Input: Inspection details, Quality Score
   - Output: AI recommendations for quality improvements

3. **Knowledge Article Generator**
   - Input: Common case patterns
   - Output: Suggested knowledge articles

### Agentforce Routing

- Route high-priority cases to specialized agents
- Route technical cases to technical team
- Auto-escalate based on customer sentiment

---

## 🔐 Security Model

### Permission Sets

1. **Customer Support Agent**
   - Full access to Cases
   - Read access to Customers, Orders
   - Write access to Knowledge

2. **Support Manager**
   - Full access to all objects
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
