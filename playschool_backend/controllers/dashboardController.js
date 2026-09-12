const Child = require("../models/Child");
const Attendance = require("../models/Attendance");
const Activity = require("../models/Activity");

exports.getDashboard = async (req, res) => {
  try {
    const totalChildren =
      await Child.countDocuments();

    const now = new Date();

    const today =
        now.getFullYear() +
        "-" +
        String(now.getMonth() + 1)
            .padStart(2, "0") +
        "-" +
        String(now.getDate())
            .padStart(2, "0");

    const presentToday =
      await Attendance.countDocuments({
        date: today,
        status: "Present",
      });

    const absentToday =
      await Attendance.countDocuments({
        date: today,
        status: "Absent",
      });

    const activities =
      await Activity.countDocuments();

    res.json({
      totalChildren,
      presentToday,
      absentToday,
      activities,
    });
    console.log(
  "Today:",
  new Date()
    .toISOString()
    .split("T")[0]
);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
  
};