const mongoose = require("mongoose");

const feeSchema = new mongoose.Schema(
  {
    childId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Child",
      required: true,
    },

    month: {
      type: String,
      required: true,
    },

    monthlyFee: {
      type: Number,
      required: true,
    },

    paidAmount: {
      type: Number,
      default: 0,
    },

    status: {
      type: String,
      enum: ["Paid", "Pending"],
      default: "Pending",
    },

    paymentDate: {
      type: String,
      default: "",
    },

    paymentMethod: {
      type: String,
      default: "",
    },
  },
  {
    timestamps: true,
  }
);

feeSchema.index(
  {
    childId: 1,
    month: 1,
  },
  {
    unique: true,
  }
);

module.exports =
  mongoose.model(
    "Fee",
    feeSchema
  );