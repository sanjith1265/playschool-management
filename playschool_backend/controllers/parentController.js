const Parent = require("../models/Parent");

exports.createParent = async (req, res) => {
  try {
    const existingParent = await Parent.findOne({
      childId: req.body.childId,
    });

    if (existingParent) {
      return res.status(400).json({
        message: "Parent details already exist for this child.",
      });
    }

    const parent = await Parent.create(req.body);

    res.status(201).json(parent);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.getParents = async (req, res) => {
  try {
    const parents = await Parent.find()
      .populate("childId", "name");

    res.json(parents);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.updateParent = async (req, res) => {
  try {
    const parent = await Parent.findByIdAndUpdate(
      req.params.id,
      req.body,
      {
        new: true,
      }
    );

    res.json(parent);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.deleteParent = async (req, res) => {
  try {
    await Parent.findByIdAndDelete(req.params.id);

    res.json({
      message: "Parent deleted successfully",
    });
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};