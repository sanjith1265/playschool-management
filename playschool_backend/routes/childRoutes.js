const express = require("express");

const router = express.Router();

const {
  createChild,
  getChildren,
  getChildById,
  updateChild,
  deleteChild,
} = require(
  "../controllers/childController"
);

router.post("/", createChild);

router.get("/", getChildren);

router.get("/:id", getChildById);

router.put("/:id", updateChild);

router.delete("/:id", deleteChild);

module.exports = router;