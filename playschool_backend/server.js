const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const authRoutes = require("./routes/authRoutes");
dotenv.config();
const childRoutes = require("./routes/childRoutes");
const connectDB = require("./config/db");
const attendanceRoutes = require("./routes/attendanceRoutes");
const activityRoutes = require("./routes/activityRoutes");
const feeRoutes = require("./routes/feeRoutes");
const dashboardRoutes = require("./routes/dashboardRoutes");
const parentRoutes = require("./routes/parentRoutes");

connectDB();

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Backend Running");
});

const PORT = process.env.PORT || 5000;
app.use(
  "/api/auth",
  authRoutes
);

app.use(
  "/api/children",
  childRoutes
);

app.use(
  "/api/attendance",
  attendanceRoutes
);

app.use(
  "/api/activities",
  activityRoutes
);

app.use(
  "/api/fees",
  feeRoutes
);

app.use(
  "/api/dashboard",
  dashboardRoutes
);

app.use("/api/parents", parentRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});