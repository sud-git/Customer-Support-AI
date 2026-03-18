# Field Metadata Reference

## Custom Field Specifications

### Customer__c Fields

| Field API Name | Label | Type | Required | Unique | External | Details |
|---|---|---|---|---|---|---|
| CustomerName__c | Customer Name | Text | ✓ | | | 255 char, Tracked |
| CustomerEmail__c | Email | Email | ✓ | ✓ | ✓ | External ID |
| CustomerPhone__c | Phone | Phone | | | | Format validated |
| CustomerStatus__c | Status | Picklist | | | | Active/Inactive/Suspended |
| City__c | City | Text | | | | 50 char |
| State__c | State | Text | | | | 50 char |
| Country__c | Country | Text | | | | 100 char |
| TotalOrders__c | Total Orders | Number | | | | Rollup summary |
| TotalSpend__c | Total Spend | Currency | | | | Rollup summary |
| CustomerType__c | Customer Type | Picklist | | | | Personal/Business |
| Notes__c | Notes | LongTextArea | | | | 1000 char, 3 lines |

---

### Merchandise__c Fields

| Field API Name | Label | Type | Required | Details |
|---|---|---|---|---|
| MerchandiseName__c | Product Name | Text | ✓ | 255 char |
| SKU__c | SKU | Text | ✓ | External ID, Unique |
| Category__c | Category | Picklist | | Electronics/Clothing/Home/Sports/Other |
| Price__c | Price | Currency | ✓ | 10 digits, 2 decimals |
| Stock__c | Stock Quantity | Number | | 6 digits, 0 decimals |
| Description__c | Description | LongTextArea | | 2000 char, 5 lines |
| IsActive__c | Active | Checkbox | | Default: true |
| MinStock__c | Minimum Stock Level | Number | | 6 digits, 0 decimals |
| Supplier__c | Supplier | Text | | 100 char |

---

### Order__c Fields

| Field API Name | Label | Type | Details |
|---|---|---|---|
| CustomerLink__c | Customer | MasterDetail | References Customer__c (required) |
| OrderDate__c | Order Date | Date | Required, Tracked |
| OrderStatus__c | Status | Picklist | Pending/Processing/Shipped/Delivered/Cancelled |
| TotalAmount__c | Total Amount | Currency | 12 digits, 2 decimals |
| ShippingAddress__c | Shipping Address | LongTextArea | 500 char, 3 lines |
| TrackingNumber__c | Tracking Number | Text | 50 char, Tracked |
| ShippingDate__c | Shipping Date | Date | Tracked |
| DeliveryDate__c | Expected Delivery Date | Date | Tracked |
| Quantity__c | Quantity | Number | 6 digits, Tracked |
| Notes__c | Notes | LongTextArea | 1000 char, 3 lines |

---

### Case__c Fields

| Field API Name | Label | Type | Details |
|---|---|---|---|
| CustomerLink__c | Customer | Lookup | References Customer__c |
| CaseTitle__c | Case Title | Text | 255 char, Required, Tracked |
| CaseDescription__c | Description | LongTextArea | 4000 char, Required, Feed History |
| CaseType__c | Case Type | Picklist | Technical/Billing/Product/Complaint/Feature |
| Priority__c | Priority | Picklist | Low/Medium/High/Critical |
| Status__c | Status | Picklist | New/In Progress/Waiting/Resolved/Closed |
| AssignedAgent__c | Assigned Agent | Lookup | References User |
| Resolution__c | Resolution | LongTextArea | 4000 char, 7 lines |
| AISummary__c | AI Summary | LongTextArea | 4000 char, AI-generated, 5 lines |
| RelatedKnowledge__c | Related Knowledge | Lookup | References Knowledge__c |
| CreatedDate__c | Creation Date | DateTime | System field |
| ResolvedDate__c | Resolved Date | DateTime | Tracked |

---

### Knowledge__c Fields

| Field API Name | Label | Type | Details |
|---|---|---|---|
| ArticleTitle__c | Article Title | Text | 255 char, Required, Tracked |
| ArticleContent__c | Article Content | LongTextArea | 32000 char, Required, 10 lines |
| Topic__c | Topic | Picklist | Setup/Troubleshooting/Billing/Returns/Shipping |
| IsPublished__c | Published | Checkbox | Default: false, Tracked |
| CreatedBy__c | Author | Lookup | References User |
| Keywords__c | Keywords | Text | 255 char, Search optimization |
| ViewCount__c | View Count | Number | 6 digits |
| Helpful__c | Helpful Count | Number | 6 digits |

---

### Inspection__c Fields

| Field API Name | Label | Type | Details |
|---|---|---|---|
| OrderLink__c | Order | MasterDetail | References Order__c (required, ControlledByParent) |
| InspectionDate__c | Inspection Date | Date | Required, Tracked |
| InspectionStatus__c | Inspection Status | Picklist | Passed/Failed/Pending Review, Default: Pending |
| QualityScore__c | Quality Score | Number | 3 digits (0-100), Tracked |
| AISummary__c | AI Summary | LongTextArea | 2000 char, AI-generated, 5 lines |
| Comments__c | Comments | LongTextArea | 2000 char, 5 lines |
| InspectedBy__c | Inspected By | Lookup | References User |
| DefectsFound__c | Defects Found | Number | 4 digits, Tracked |

---

## Picklist Values Reference

### CustomerStatus__c
- Active (default)
- Inactive
- Suspended

### CustomerType__c
- Personal
- Business

### Category__c (Merchandise)
- Electronics
- Clothing
- Home
- Sports
- Other

### OrderStatus__c
- Pending (default)
- Processing
- Shipped
- Delivered
- Cancelled

### CaseType__c
- Technical Issue
- Billing Inquiry
- Product Question
- Complaint
- Feature Request

### Priority__c
- Low
- Medium (default)
- High
- Critical

### Status__c (Case)
- New (default)
- In Progress
- Waiting for Customer
- Resolved
- Closed

### Topic__c (Knowledge)
- Product Setup
- Troubleshooting
- Billing FAQ
- Returns & Refunds
- Shipping & Delivery

### InspectionStatus__c
- Passed
- Failed
- Pending Review (default)

---

## Auto-Number Formats

| Object | Format | Example | Tracking |
|---|---|---|---|
| Customer | CUST-{00000} | CUST-00001 | Auto-increments |
| Merchandise | PRDT-{00000} | PRDT-00001 | Auto-increments |
| Order | ORD-{00000000} | ORD-00000001 | Auto-increments |
| Case | CS-{00000000} | CS-00000001 | Auto-increments |
| Knowledge | KB-{00000000} | KB-00000001 | Auto-increments |
| Inspection | INS-{00000000} | INS-00000001 | Auto-increments |

---

## Relationship Summary

| From Object | To Object | Type | API Name | Label | Cardinality |
|---|---|---|---|---|---|
| Order | Customer | Master-Detail | CustomerLink__c | Customer | M:1 |
| Inspection | Order | Master-Detail | OrderLink__c | Order | M:1 |
| Case | Customer | Lookup | CustomerLink__c | Customer | M:1 |
| Case | Knowledge | Lookup | RelatedKnowledge__c | Related Knowledge | M:1 |
| Case | User | Lookup | AssignedAgent__c | Assigned Agent | M:1 |
| Inspection | User | Lookup | InspectedBy__c | Inspected By | M:1 |
| Knowledge | User | Lookup | CreatedBy__c | Author | M:1 |

---

## Field Tracking Configuration

### Fields with History Tracking Enabled
```
Customer__c:
  - CustomerName__c
  - CustomerEmail__c
  - CustomerPhone__c
  - CustomerStatus__c
  - City__c, State__c, Country__c
  - TotalOrders__c, TotalSpend__c

Order__c:
  - OrderDate__c
  - OrderStatus__c
  - TotalAmount__c
  - TrackingNumber__c
  - ShippingDate__c, DeliveryDate__c
  - Quantity__c

Case__c:
  - CaseTitle__c
  - CaseType__c
  - Priority__c
  - Status__c
  - AssignedAgent__c
  - ResolvedDate__c
  - RelatedKnowledge__c

Inspection__c:
  - InspectionDate__c
  - InspectionStatus__c
  - QualityScore__c
  - InspectedBy__c
  - DefectsFound__c
```

---

## Field Validation Rules (To Be Created)

### Possible Validations

```
Case Priority & Status:
- IF Status = Closed THEN Priority must be empty or null
- IF Priority = Critical THEN Status cannot be null

Order Amount:
- TotalAmount__c must be > 0

Inspection Quality:
- QualityScore__c must be between 0 and 100
- IF InspectionStatus = Passed THEN QualityScore must be >= 70

Customer Status Changes:
- If changing from Active to Suspended, require comment
```

---

## Custom Field Search Optimization

### Recommended Indexed Fields
- Customer__c.CustomerEmail__c (External ID)
- Order__c.CustomerLink__c (Relationship)
- Case__c.CustomerLink__c (Relationship)
- Case__c.Status__c (Picklist filter)
- Inspection__c.InspectionStatus__c (Picklist filter)
- Merchandise__c.SKU__c (External ID)

