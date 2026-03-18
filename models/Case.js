import mongoose from 'mongoose';

const caseSchema = new mongoose.Schema(
  {
    customerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Customer',
      required: true,
    },
    subject: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    status: {
      type: String,
      enum: ['New', 'Open', 'In Progress', 'Resolved', 'Closed'],
      default: 'New',
    },
    priority: {
      type: String,
      enum: ['Low', 'Medium', 'High', 'Critical'],
      default: 'Medium',
    },
    caseType: {
      type: String,
      enum: ['Question', 'Problem', 'Feature Request', 'Bug Report', 'General Inquiry'],
      default: 'Question',
    },
    assignedTo: String,
    relatedKnowledgeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Knowledge',
    },
    aiSummary: String,
    resolution: String,
    resolvedAt: Date,
    createdAt: {
      type: Date,
      default: Date.now,
    },
    updatedAt: {
      type: Date,
      default: Date.now,
    },
  },
  { timestamps: true }
);

export default mongoose.models.Case || mongoose.model('Case', caseSchema);
