const express = require("express");

const router = express.Router();

const {
  markAttendance,
  getAttendance,
  getAttendanceByDate,
} = require("../controllers/attendanceController");

router.post(
  "/",
  markAttendance
);

router.get(
  "/",
  getAttendance
);

router.get(
  "/date/:date",
  getAttendanceByDate
);

module.exports = router;