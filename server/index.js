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

// patient auth route
const patientAuthRoutes = require("./routes/patient.auth.routes");
app.use("/patient/auth", patientAuthRoutes);

// doctor auth route
const doctorAuthRoutes = require("./routes/doctor.auth.routes");
app.use("/doctor/auth", doctorAuthRoutes);

// pharmacy auth route
const pharmacyAuthRoutes = require("./routes/pharmacy.auth.routes");
app.use("/pharmacy/auth", pharmacyAuthRoutes);

const { authenticateToken } = require("./middleware/auth.middleware");

// patient routes
const patientRoutes = require("./routes/patient.routes");
app.use("/", authenticateToken, patientRoutes);

// prescription routes
const prescriptionRoutes = require("./routes/prescription.routes");
app.use("/", authenticateToken, prescriptionRoutes);

// pharmacy routes
const pharmacyRoutes = require("./routes/pharmacy.routes");
app.use("/", authenticateToken, pharmacyRoutes);

// medicine routes
const medicineRoutes = require("./routes/medicine.routes");
app.use("/", authenticateToken, medicineRoutes);

// medication order routes
const medicationOrderRoutes = require("./routes/medication.order.routes");
app.use("/", authenticateToken, medicationOrderRoutes);

// doctor routes
const doctorRoutes = require("./routes/doctor.routes");
app.use("/", authenticateToken, doctorRoutes);

// chat routes
const chatRoutes = require("./routes/chat.routes");
app.use("/", authenticateToken, chatRoutes);

// appointment routes
const appointmentRoutes = require("./routes/appintment.routes");
app.use("/", authenticateToken, appointmentRoutes);

app.use(cors({ origin: "http://localhost:3000" }));

//Listening on server port and logging status
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log("Server listining on PORT: ", PORT);
  connectToMongoDB();
});
