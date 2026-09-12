const Attendance = require(
  "../models/Attendance"
);

exports.markAttendance = async (req, res) => {
  try {

    const attendance =
      await Attendance.findOneAndUpdate(
        {
          childId: req.body.childId,
          date: req.body.date,
        },
        {
          status: req.body.status,
        },
        {
          new: true,
          upsert: true,
        }
      );

    res.status(200).json(attendance);

  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.getAttendance =
  async (req, res) => {
    try {
      const attendance =
        await Attendance.find()
          .populate(
            "childId",
            "name"
          );

      res.json(attendance);
    } catch (error) {
      res.status(500).json({
        message:
          error.message,
      });
    }
  };
  
exports.getAttendanceByDate =
  async (req, res) => {
    try {

      const attendance =
        await Attendance.find({
          date: req.params.date,
        }).populate(
          "childId",
          "name"
        );

      res.json(attendance);

    } catch (error) {
      res.status(500).json({
        message: error.message,
      });
    }
  };