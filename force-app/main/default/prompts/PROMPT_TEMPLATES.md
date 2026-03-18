# Salesforce Prompt Builder Templates
# For AI-Powered Customer Support System

## Template 1: Case Summary Generator

**Prompt Name:** GenerateCaseSummary

**Input Variables:**
- `{caseTitle}` - Title of the case
- `{caseDescription}` - Full case description  
- `{caseType}` - Type of case (Technical, Billing, etc.)
- `{customerHistory}` - Previous case history for customer

**Prompt Text:**
```
You are a customer support AI assistant. Analyze the following support case and provide:
1. A concise summary (2-3 sentences)
2. Root cause analysis
3. Recommended resolution path
4. Suggested knowledge articles

CASE INFORMATION:
Title: {caseTitle}
Type: {caseType}
Description: {caseDescription}
Customer History: {customerHistory}

Provide response in professional, clear language.
Response should be actionable and include priority level.
```

**Output Field:** Case__c.AISummary__c

**Model:** Claude or GPT-4 (via integration)

---

## Template 2: Inspection Quality Assessment

**Prompt Name:** GenerateInspectionSummary

**Input Variables:**
- `{qualityScore}` - Quality score (0-100)
- `{defectsFound}` - Number of defects
- `{inspectionNotes}` - Inspection notes
- `{productCategory}` - Product category

**Prompt Text:**
```
You are a Quality Assurance AI system. Analyze the inspection data and provide:
1. Assessment of quality level (Excellent/Good/Acceptable/Poor)
2. Specific recommendations for improvement
3. Risk level if product ships as-is
4. Suggested remediation actions
5. Next steps for QA team

INSPECTION DATA:
Quality Score: {qualityScore}/100
Defects Found: {defectsFound}
Product Category: {productCategory}
Detailed Notes: {inspectionNotes}

Provide structured recommendations in JSON format when possible.
Focus on actionable insights for the production team.
```

**Output Field:** Inspection__c.AISummary__c

**Model:** Claude or GPT-4

---

## Template 3: Knowledge Article Suggestion

**Prompt Name:** SuggestKnowledgeArticles

**Input Variables:**
- `{caseDescription}` - Case description
- `{caseType}` - Type of issue
- `{existingArticles}` - List of existing knowledge articles

**Prompt Text:**
```
You are a Knowledge Management AI. Based on the customer's issue, suggest relevant knowledge articles or determine if a new article should be created.

CUSTOMER ISSUE:
{caseDescription}

Issue Type: {caseType}

EXISTING KNOWLEDGE BASE:
{existingArticles}

Provide:
1. List of 3-5 most relevant existing articles with relevance score
2. Gap analysis - what information is missing from knowledge base
3. Suggested new article title and brief outline if needed
4. Keywords for articles to improve discoverability

Response format: JSON with articles array and recommendations.
```

**Output Field:** Custom response handling

**Model:** Claude or GPT-4

---

## Template 4: Customer Sentiment Analysis

**Prompt Name:** AnalyzeCustomerSentiment

**Input Variables:**
- `{caseDescription}` - Customer message
- `{previousCases}` - Previous interactions summary
- `{sentiment}` - Initial sentiment flag

**Prompt Text:**
```
You are a Customer Experience AI. Analyze the customer's tone and emotional state:

CUSTOMER MESSAGE:
{caseDescription}

CUSTOMER HISTORY:
{previousCases}

Provide:
1. Sentiment analysis (Positive/Neutral/Negative/Angry/Confused)
2. Emotion indicators
3. Escalation risk level (Low/Medium/High/Critical)
4. Recommended agent response tone
5. Suggested next steps to retain/satisfy customer

Return structured JSON response with clear escalation flag if needed.
Priority: Identify if customer escalation is needed.
```

**Output Field:** Case routing and priority override

**Model:** Claude or GPT-4

---

## Template 5: Order Problem Diagnosis

**Prompt Name:** DiagnoseOrderIssue

**Input Variables:**
- `{caseDescription}` - Customer's problem description
- `{orderDetails}` - Order information (status, items, etc.)
- `{shippingInfo}` - Shipping and tracking details

**Prompt Text:**
```
You are an Order Fulfillment AI. Help diagnose the customer's order issue:

PROBLEM REPORTED:
{caseDescription}

ORDER DETAILS:
{orderDetails}

SHIPPING INFORMATION:
{shippingInfo}

Determine:
1. Most likely root cause
2. Is this a shipping, product, or system issue?
3. Immediate customer action (if any)
4. Resolution path (refund/reship/replacement/credit)
5. Estimated resolution time
6. Follow-up actions needed

Provide response as if speaking to a support agent.
Be specific about resolution options and success probability.
```

**Output Field:** Case resolution recommendations

**Model:** Claude or GPT-4

---

## Integration Steps in Salesforce:

### 1. Access Prompt Builder
- Go to Setup → Prompt Builder
- Create new prompt for each template above

### 2. Configure Input/Output  
- Map input variables to Case/Inspection fields
- Set output to populate AISummary__c field

### 3. Test Prompts
- Via Prompt Builder test interface
- With sample case data
- Validate output formatting

### 4. Connect to Flows
- Create Flow that triggers prompt on case creation
- Update case with generated summary
- Route based on analysis results

### 5. Monitor and Refine
- Track prompt accuracy and usefulness
- Gather feedback from support team
- Iterate on prompt wording/structure

---

## Agentforce Configuration:

### Agent Skills (To Be Created):
1. **Resolve Cases** - Use Case Summary Generator
2. **Assess Quality** - Use Inspection Assessment  
3. **Find Knowledge** - Use Knowledge Article Suggester
4. **Route Complex Cases** - Use Sentiment Analysis

### Intent Detection:
- Input: Customer message
- Route to appropriate skill based on intent
- Execute Prompt Template
- Return result to customer or agent

### Conversation Flow:
```
Customer Query
    ↓
Natural Language Understanding (NLU)
    ↓
Intent Classification
    ↓
Route to Appropriate Skill
    ↓
Execute Prompt Template
    ↓
Format Response
    ↓
Return to Customer/Agent
```

---

## Production Deployment Checklist:

- [ ] All 5 templates created in Prompt Builder
- [ ] Input variables mapped correctly
- [ ] Output fields configured
- [ ] Test cases validated with sample data
- [ ] Flows configured to trigger prompts
- [ ] Agentforce skills linked to prompts
- [ ] Agent routing rules configured
- [ ] Conversation samples reviewed
- [ ] Error handling implemented
- [ ] Monitoring and metrics set up

