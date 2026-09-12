const mongoose = require("mongoose");

const attendanceSchema =
  new mongoose.Schema(
    {
      childId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Child",
        required: true,
      },

      date: {
        type: String,
        required: true,
      },

      status: {
        type: String,
        enum: [
          "Present",
          "Absent",
        ],
        required: true,
      },
    },
    {
      timestamps: true,
    }
  );
  attendanceSchema.index(
  {
    childId: 1,
    date: 1,
  },
  {
    unique: true,
  }
);

module.exports = mongoose.model(
  "Attendance",
  attendanceSchema
);