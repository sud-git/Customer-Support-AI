import mongoose from 'mongoose';

const merchandiseSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    sku: {
      type: String,
      required: true,
      unique: true,
    },
    category: String,
    price: {
      type: Number,
      required: true,
      min: 0,
    },
    stock: {
      type: Number,
      default: 0,
      min: 0,
    },
    minStock: {
      type: Number,
      default: 10,
    },
    description: String,
    active: {
      type: Boolean,
      default: true,
    },
    supplier: String,
    weight: Number,
    dimensions: String,
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

export default mongoose.models.Merchandise || mongoose.model('Merchandise', merchandiseSchema);
