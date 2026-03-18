# Salesforce AI Customer Support System Architecture

## 📐 System Architecture

### Three-Layer Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  (Lightning App, Record Pages, Reports, Dashboards)          │
└────────┬─────────────────────────────────┬───────────────────┘
         │                                 │
┌────────▼──────────────────────────────────▼───────────────────┐
│              APPLICATION LOGIC LAYER                           │
│  ┌──────────────────────────────────────────────────────────┐ │
│  │ Agentforce                                               │ │
│  │  - Case routing and assignment                           │ │
│  │  - Customer sentiment analysis                           │ │
│  │  - Automated responses                                   │ │
│  └──────────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────────┐ │
│  │ Flows                                                    │ │
│  │  - Case auto-routing                                    │ │
│  │  - Approval workflows                                   │ │
│  │  - Notification triggers                                │ │
│  └──────────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────────┐ │
│  │ Apex Classes                                             │ │
│  │  - CaseAutoResponder                                    │ │
│  │  - InspectionSummaryService                             │ │
│  │  - CustomerSupportUtility                               │ │
│  └──────────────────────────────────────────────────────────┘ │
└────────┬─────────────────────────────────┬───────────────────┘
         │                                 │
┌────────▼──────────────────────────────────▼───────────────────┐
│                    DATA LAYER                                  │
│  ┌──────────────────────────────────────────────────────────┐ │
│  │ Custom Objects                                           │ │
│  │  - Customer__c                                           │ │
│  │  - Merchandise__c                                        │ │
│  │  - Order__c (→ Customer)                                 │ │
│  │  - Case__c (→ Customer, Knowledge)                       │ │
│  │  - Knowledge__c                                          │ │
│  │  - Inspection__c (→ Order)                               │ │
│  └──────────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────────┐ │
│  │ Salesforce Database                                      │ │
│  │  - 6 Custom Objects                                      │ │
│  │  - ~50 Custom Fields                                     │ │
│  │  - Master-Detail & Lookup Relationships                  │ │
│  └──────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔄 Data Flow Diagram

### Case Resolution Flow

```
Customer Submits Case
        ↓
    Case__c created
        ↓
CaseTrigger fires
        ↓
CaseAutoResponder.processCaseSummaries()
        ├─→ Generate AI Summary (via Prompt Builder)
        ├─→ Populate AISummary__c field
        └─→ Route to appropriate Agent
        ↓
Flow: Case Auto-Response
        ├─→ Check priority
        ├─→ Assign agent
        └─→ Send notification
        ↓
Agent Reviews Case
        ├─→ Views AISummary__c
        ├─→ Links Related Knowledge
        └─→ Resolves issue
        ↓
Case Status = Resolved
        ↓
Agentforce suggests similar cases
        ↓
Customer Satisfaction tracked
```

### Order Inspection Flow

```
Order Created
        ↓
Order__c record created
        ↓
Inspection scheduled
        ↓
Quality team performs inspection
        ↓
Inspection__c record created
        ↓
InspectionTrigger fires
        ↓
InspectionSummaryService.generateInspectionSummary()
        ├─→ Analyze quality score
        ├─→ Generate AI recommendations
        └─→ Populate AISummary__c
        ↓
If quality < threshold:
        ├─→ Flag for rework
        └─→ Notify supervisor
        ↓
If quality > threshold:
        └─→ Approve for shipment
        ↓
Order status updates automatically
        ↓
Customer notification sent
```

---

## 🔗 Object Relationships

### Entity-Relationship Diagram (ERD)

```
┌─────────────────┐
│   Customer      │ (1)
│  ┌───────────┐  │
│  │ CustID    │  │
│  │ Name      │  │
│  │ Email     │  │
│  │ Status    │  │
│  └───────────┘  │
└────┬────────────┘
     │ (M)
     │ Master-Detail
     │
   ┌─┴──────────────────────────┐
   │                            │
   ▼(M)                        ▼(M)
┌─────────────────┐      ┌─────────────────┐
│    Order        │      │     Case        │
│ ┌───────────┐   │      │ ┌───────────┐   │
│ │ OrderID   │   │      │ │ CaseID    │   │
│ │ CustID(FK)│ ◄─┴──────┤─┤ CustID(FK)│   │
│ │ Date      │   │      │ │ Title     │   │
│ │ Status    │   │      │ │ Priority  │   │
│ │ Amount    │   │      │ │ Status    │   │
│ └───────────┘   │      │ │ KnowID(FK)├──┐
└────┬────────────┘      │ └───────────┘   │
     │                    │                │
     │ (M)               │(M)             │
     │ Master-Det        │ Lookup         │
     │                    │                │
   ┌─┴──────────────────┐ │                │
   │                    │ │                │
   ▼(M)                 ▼ ▼                │
┌─────────────────┐  ┌─────────────────┐  │
│  Inspection     │  │   Knowledge     │  │
│ ┌───────────┐   │  │ ┌───────────┐   │  │
│ │ InspID    │   │  │ │ ArticleID │   │◄─┘
│ │ OrderID   │ ◄─┤  │ │ Title     │   │
│ │ Date      │   │  │ │ Content   │   │
│ │ Score     │   │  │ │ Published │   │
│ │ Status    │   │  │ └───────────┘   │
│ └───────────┘   │  │                 │
└─────────────────┘  └─────────────────┘

┌─────────────────┐
│   Merchandise   │ (Standalone)
│ ┌───────────┐   │
│ │ ProdID    │   │
│ │ Name      │   │
│ │ SKU       │   │
│ │ Price     │   │
│ │ Stock     │   │
│ └───────────┘   │
└─────────────────┘
```

---

## 📊 Field Mappings & Calculations

### Customer Rollup Fields (Calculated)

```
TotalOrders__c = COUNT(Order__c WHERE CustomerLink = CustomerID)
TotalSpend__c = SUM(Order__c.TotalAmount__c WHERE CustomerLink = CustomerID)
```

### Order Status Automatic Updates

```
OrderStatus = Pending
    ↓ (via Flow/Automation)
OrderStatus = Processing (when inspection starts)
    ↓ (via Flow/Automation)
OrderStatus = Shipped (when tracking # added)
    ↓ (via Flow/Automation)
OrderStatus = Delivered (when delivery date reached)
```

### Case Priority & Routing Logic

```
IF Priority = Critical → Route to SENIOR_AGENT
ELSE IF CaseType = Technical → Route to TECHNICAL_AGENT
ELSE IF CaseType = Billing → Route to BILLING_AGENT
ELSE → Route to GENERAL_AGENT
```

---

## 🤖 AI Integration Points

### Prompt Builder Integration

```
CASE OBJECT
    ├─ CaseTitle__c (INPUT)
    ├─ CaseDescription__c (INPUT)
    ├─ CaseType__c (INPUT)
    ├─ [Prompt Builder Call]
    └─ AISummary__c (OUTPUT)

INSPECTION OBJECT
    ├─ QualityScore__c (INPUT)
    ├─ DefectsFound__c (INPUT)
    ├─ InspectionStatus__c (INPUT)
    ├─ [Prompt Builder Call]
    └─ AISummary__c (OUTPUT)
```

### Agentforce Routing

```
CONVERSATION INPUT
    ↓
Natural Language Processing
    ↓
Intent Classification
    ├─ Resolve Case
    ├─ Track Order
    ├─ Find Knowledge
    └─ Submit Complaint
    ↓
Route to Appropriate Skill
    ↓
Execute Prompt Template
    ↓
Generate Response
    ↓
Return to Customer
```

---

## 🔐 Security & Permissions

### Field-Level Security

```
CUSTOMER SUPPORT AGENT (Permission Set)
├─ Customer__c
│  ├─ CustomerName__c (Read, Update)
│  ├─ CustomerEmail__c (Read)
│  └─ CustomerStatus__c (Read, Update)
├─ Order__c
│  ├─ OrderStatus__c (Read, Update)
│  └─ TotalAmount__c (Read)
├─ Case__c
│  ├─ CaseTitle__c (Create, Read, Update)
│  ├─ CaseDescription__c (Create, Read, Update)
│  ├─ Priority__c (Read, Update)
│  ├─ Status__c (Read, Update)
│  └─ AISummary__c (Read)
└─ Knowledge__c
   └─ ArticleContent__c (Read)
```

### Object-Level Sharing

```
Customer__c      → ReadWrite (Team based)
Merchandise__c   → Read (All agents)
Order__c         → ControlledByParent (via Customer)
Case__c          → ReadWrite (Team based)
Knowledge__c     → ReadWrite (Authors only)
Inspection__c    → ControlledByParent (via Order)
```

---

## 📈 Scalability Considerations

### Governor Limits Planning

```
Batch Sizes:
- Case Processing Batch: 200 records/batch
- Inspection Processing Batch: 100 records/batch
- Customer Query Limits: 50K+ records with pagination

API Rate Limits:
- Agentforce: 1000 calls/day (starting)
- Prompt Builder: Depends on model subscription
- Data Import: 10K records/hour

Storage:
- 6 Custom Objects × 50 Fields × 1M records = ~300MB
- Attachments/Files: Plan for 500GB initially
- Logs & Audit Trail: Auto-purged after 90 days
```

### Performance Optimization

```
Indexes on Frequently Queried Fields:
- Customer__c.CustomerEmail__c (External ID)
- Case__c.CustomerLink__c (Relationship)
- Order__c.OrderStatus__c (Picklist Filter)
- Inspection__c.InspectionStatus__c (Status Filter)

Avoid Full Table Scans:
All queries include WHERE clause with indexed field
```

---

## 🔄 Integration Points

### External System Integration

```
[External CRM]
    ↓ (API)
Salesforce
    ├─ REST API for Customer data sync
    ├─ SFDC to external ticketing via middleware
    ├─ Webhook for real-time updates
    └─ Scheduled batch for nightly sync

[Analytics Dashboard]
    ↙ (Query)
Einstein Analytics
    ├─ Case metrics dashboard
    ├─ Customer satisfaction trends
    ├─ Quality inspection reports
    └─ Agent performance scorecards
```

---

## 📋 Database Schema Summary

### Table Definitions

```sql
-- Pseudo-SQL for reference

CREATE TABLE Customer__c (
    Id UUID PRIMARY KEY,
    CustomerName__c VARCHAR(255) NOT NULL,
    CustomerEmail__c VARCHAR(255) UNIQUE NOT NULL,
    CustomerPhone__c VARCHAR(20),
    CustomerStatus__c PICKLIST (Active, Inactive, Suspended),
    City__c VARCHAR(50),
    State__c VARCHAR(50),
    Country__c VARCHAR(100),
    TotalOrders__c NUMBER,
    TotalSpend__c CURRENCY,
    CustomerType__c PICKLIST (Personal, Business),
    Notes__c TEXT,
    CreatedDate DATETIME,
    LastModifiedDate DATETIME
);

CREATE TABLE Order__c (
    Id UUID PRIMARY KEY,
    CustomerLink__c UUID FOREIGN KEY references Customer__c,
    OrderDate__c DATE NOT NULL,
    OrderStatus__c PICKLIST (Pending, Processing, Shipped, Delivered, Cancelled),
    TotalAmount__c CURRENCY,
    ShippingAddress__c TEXT,
    TrackingNumber__c VARCHAR(50),
    ShippingDate__c DATE,
    DeliveryDate__c DATE,
    Quantity__c NUMBER,
    Notes__c TEXT
);

CREATE TABLE Case__c (
    Id UUID PRIMARY KEY,
    CustomerLink__c UUID FOREIGN KEY references Customer__c,
    CaseTitle__c VARCHAR(255) NOT NULL,
    CaseDescription__c TEXT NOT NULL,
    CaseType__c PICKLIST (..),
    Priority__c PICKLIST (Low, Medium, High, Critical),
    Status__c PICKLIST (..),
    AssignedAgent__c UUID FOREIGN KEY references User,
    AISummary__c TEXT,
    RelatedKnowledge__c UUID FOREIGN KEY references Knowledge__c
);

-- Similar for Merchandise__c, Inspection__c, Knowledge__c
```

---

## ✅ Architecture Review Checklist

- [x] Objects properly normalized
- [x] No circular dependencies
- [x] Master-Detail relationships appropriate
- [x] Lookup relationships for flexibility
- [x] Audit trail enabled on all objects
- [x] Field-level security configured
- [x] Apex classes optimized for bulk operations
- [x] Triggers follow best practices (bulkified)
- [x] No recursive trigger issues
- [x] Governor limits considered
- [x] Scalability planned for 1M+ records
- [x] AI integration points identified
- [x] Agentforce routing logic defined
- [x] Backup strategy considered

