const Activity = require(
  "../models/Activity"
);

exports.createActivity =
  async (req, res) => {
    try {
      const activity =
        await Activity.create(
          req.body
        );

      res.status(201).json(
        activity
      );
    } catch (error) {
      res.status(500).json({
        message:
          error.message,
      });
    }
  };

exports.getActivities =
  async (req, res) => {
    try {
      const activities =
        await Activity.find()
          .sort({
            date: -1,
          });

      res.json(activities);
    } catch (error) {
      res.status(500).json({
        message:
          error.message,
      });
    }
  };