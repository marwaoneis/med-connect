const express = require("express");
const { connectToMongoDB } = require("./config/mongoDb.config");
require("dotenv").config();
const cors = require("cors");

//Initilizing app as express method
const app = express();
app.use(express.json());

app.get("/hello", (req, res) => {
  console.log("HELLO MARWAAAA!!");
});

// auth route
// const authRoutes = require("./routes/auth.routes");
// app.use("/auth", authRoutes);

// patient routes
const patientRoutes = require("./routes/patient.routes");
app.use("/patient", patientRoutes);

// prescription routes
const prescriptionRoutes = require("./routes/prescription.routes");
app.use("/prescription", prescriptionRoutes);

// pharmacy routes
const pharmacyRoutes = require("./routes/pharmacy.routes");
app.use("/pharmacy", pharmacyRoutes);

// medicine routes
const medicineRoutes = require("./routes/medicine.routes");
app.use("/medicine", medicineRoutes);

// medication order routes
const medicationOrderRoutes = require("./routes/medication.order.routes");
app.use("/medication-order", medicationOrderRoutes);

// doctor routes
const doctorRoutes = require("./routes/doctor.routes");
app.use("/doctor", doctorRoutes);

// chat routes
const chatRoutes = require("./routes/chat.routes");
app.use("/chat", chatRoutes);

// appointment routes
const appointmentRoutes = require("./routes/appintment.routes");
app.use("/appointment", appointmentRoutes);

app.use(cors({ origin: "http://localhost:3000" }));

//Listening on server port and logging status
app.listen(process.env.PORT, () => {
  console.log("Server listining on PORT: ", process.env.PORT);
  connectToMongoDB();
});
