const express = require(
  "express"
);

const router =
  express.Router();

const {
  createFee,
  getFees,
  generateMonthlyFees,
  markPaid,
} = require(
  "../controllers/feeController"
);

router.post(
  "/",
  createFee
);

router.post(
  "/generate",
  generateMonthlyFees
);

router.get(
  "/",
  getFees
);

router.put(
  "/:id/pay",
  markPaid
);

module.exports = router;