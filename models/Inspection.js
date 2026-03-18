import mongoose from 'mongoose';

const inspectionSchema = new mongoose.Schema(
  {
    orderId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Order',
      required: true,
    },
    inspectionDate: {
      type: Date,
      default: Date.now,
    },
    status: {
      type: String,
      enum: ['Pending', 'In Progress', 'Passed', 'Failed', 'Rework Required'],
      default: 'Pending',
    },
    qualityScore: {
      type: Number,
      min: 0,
      max: 100,
    },
    findings: String,
    aiSummary: String,
    recommendations: String,
    inspectedBy: String,
    issues: [
      {
        description: String,
        severity: {
          type: String,
          enum: ['Low', 'Medium', 'High', 'Critical'],
        },
      },
    ],
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

export default mongoose.models.Inspection || mongoose.model('Inspection', inspectionSchema);
