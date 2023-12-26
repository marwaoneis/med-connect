const express = require("express");
const { connectToMongoDB } = require("./config/mongoDb.config");
require("dotenv").config();
const cors = require("cors");

//Initilizing app as express method
const app = express();
app.use(express.json());

// Middlewares for parsing JSON and URL-encoded data
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// auth route
// const authRoutes = require("./routes/auth.routes");
// app.use("/auth", authRoutes);

// patient routes
const patientRoutes = require("./routes/patient.routes");
app.use("/", patientRoutes);

// prescription routes
const prescriptionRoutes = require("./routes/prescription.routes");
app.use("/", prescriptionRoutes);

// pharmacy routes
const pharmacyRoutes = require("./routes/pharmacy.routes");
app.use("/", pharmacyRoutes);

// medicine routes
const medicineRoutes = require("./routes/medicine.routes");
app.use("/", medicineRoutes);

// medication order routes
const medicationOrderRoutes = require("./routes/medication.order.routes");
app.use("/", medicationOrderRoutes);

// doctor routes
const doctorRoutes = require("./routes/doctor.routes");
app.use("/", doctorRoutes);

// chat routes
const chatRoutes = require("./routes/chat.routes");
app.use("/", chatRoutes);

// appointment routes
const appointmentRoutes = require("./routes/appintment.routes");
app.use("/", appointmentRoutes);

app.use(cors({ origin: "http://localhost:3000" }));

//Listening on server port and logging status
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log("Server listining on PORT: ", PORT);
  connectToMongoDB();
});
