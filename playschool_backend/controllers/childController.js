const Child = require("../models/Child");

exports.createChild = async (req, res) => {
  try {
    const child = await Child.create(req.body);

    res.status(201).json(child);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.getChildren = async (req, res) => {
  try {
    const children = await Child.aggregate([
    {
      $lookup: {
      from: "parents",
      localField: "_id",
      foreignField: "childId",
      as: "parent",
      },
    },
]);

    res.json(children);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.getChildById = async (req, res) => {
  try {
    const child = await Child.findById(
      req.params.id
    );

    if (!child) {
      return res.status(404).json({
        message: "Child not found",
      });
    }

    res.json(child);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.updateChild = async (req, res) => {
  try {
    const child =
      await Child.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true }
      );

    if (!child) {
      return res.status(404).json({
        message: "Child not found",
      });
    }

    res.json(child);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.deleteChild = async (req, res) => {
  try {
    const child =
      await Child.findByIdAndDelete(
        req.params.id
      );

    if (!child) {
      return res.status(404).json({
        message: "Child not found",
      });
    }

    res.json({
      message:
        "Child deleted successfully",
    });
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};