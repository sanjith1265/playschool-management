const Fee = require("../models/Fee");
const Child = require("../models/Child");

exports.generateMonthlyFees = async (req, res) => {
  try {
    const { month, monthlyFee } = req.body;

    const children = await Child.find();

    for (const child of children) {
      await Fee.findOneAndUpdate(
        {
          childId: child._id,
          month: month,
        },
        {
          childId: child._id,
          month: month,
          monthlyFee: monthlyFee,
          paidAmount: 0,
          status: "Pending",
          paymentDate: "",
        },
        {
          upsert: true,
          new: true,
        }
      );
    }

    res.json({
      message: "Monthly fees generated successfully",
    });

  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};
exports.createFee = async (req, res) => {
  try {

    if (
      req.body.paidAmount >=
      req.body.monthlyFee
    ) {
      req.body.status = "Paid";
    } else {
      req.body.status = "Pending";
    }

    const fee = await Fee.findOneAndUpdate(
      {
        childId: req.body.childId,
        month: req.body.month,
      },
      req.body,
      {
        new: true,
        upsert: true,
      }
    );

    res.status(200).json(fee);

  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
};

exports.getFees =
  async (req, res) => {
    try {

      const fees =
        await Fee.find()
          .populate(
            "childId",
            "name"
          );

      res.json(fees);

    } catch (error) {

      res.status(500).json({
        message:
          error.message,
      });

    }
  };
  exports.markPaid = async (req, res) => {
  try {

    const fee = await Fee.findById(
      req.params.id
    );

    fee.paidAmount =
      req.body.paidAmount;

    fee.paymentDate =
      req.body.paymentDate;

    fee.paymentMethod =
      req.body.paymentMethod;

    fee.status =
      fee.paidAmount >= fee.monthlyFee
          ? "Paid"
          : "Pending";

    await fee.save();

    res.json(fee);

  } catch (error) {

    res.status(500).json({
      message: error.message,
    });

  }
};