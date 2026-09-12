const express = require("express");
const router = express.Router();

const {
  createParent,
  getParents,
  updateParent,
  deleteParent,
} = require("../controllers/parentController");

router.post("/", createParent);

router.get("/", getParents);

router.put("/:id", updateParent);

router.delete("/:id", deleteParent);

module.exports = router;