const mongoose = require("mongoose");

const childSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },

  dateOfBirth: {
    type: Date,
    required: true,
  },

  gender: {
    type: String,
    required: true,
  },

  admissionDate: {
    type: Date,
    default: Date.now,
  },

  monthlyFee: {
    type: Number,
    default: 0,
  },
});

module.exports = mongoose.model("Child", childSchema);