import mongoose from 'mongoose';

const customerSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
    },
    phone: String,
    status: {
      type: String,
      enum: ['Active', 'Inactive', 'Suspended', 'Pending'],
      default: 'Active',
    },
    type: {
      type: String,
      enum: ['Personal', 'Business'],
      default: 'Personal',
    },
    address: String,
    city: String,
    state: String,
    zip: String,
    country: String,
    notes: String,
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

export default mongoose.models.Customer || mongoose.model('Customer', customerSchema);
