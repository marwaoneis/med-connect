"use strict";

var express = require("express");

var _require = require("./config/mongoDb.config"),
    connectToMongoDB = _require.connectToMongoDB;

require("dotenv").config();

var cors = require("cors"); //Initilizing app as express method


var app = express();
app.use(express.json()); // Middlewares for parsing JSON and URL-encoded data

app.use(express.json());
app.use(express.urlencoded({
  extended: true
})); // patient auth route

var patientAuthRoutes = require("./routes/patient.auth.routes");

app.use("/patient/auth", patientAuthRoutes); // doctor auth route

var doctorAuthRoutes = require("./routes/doctor.auth.routes");

app.use("/doctor/auth", doctorAuthRoutes); // pharmacy auth route

var pharmacyAuthRoutes = require("./routes/pharmacy.auth.routes");

app.use("/pharmacy/auth", pharmacyAuthRoutes);

var _require2 = require("./middleware/auth.middleware"),
    authenticateToken = _require2.authenticateToken; // patient routes


var patientRoutes = require("./routes/patient.routes");

app.use("/", authenticateToken, patientRoutes); // prescription routes

var prescriptionRoutes = require("./routes/prescription.routes");

app.use("/", authenticateToken, prescriptionRoutes); // pharmacy routes

var pharmacyRoutes = require("./routes/pharmacy.routes");

app.use("/", authenticateToken, pharmacyRoutes); // medicine routes

var medicineRoutes = require("./routes/medicine.routes");

app.use("/", authenticateToken, medicineRoutes); // medication order routes

var medicationOrderRoutes = require("./routes/medication.order.routes");

app.use("/", authenticateToken, medicationOrderRoutes); // doctor routes

var doctorRoutes = require("./routes/doctor.routes");

app.use("/", authenticateToken, doctorRoutes); // chat routes

var chatRoutes = require("./routes/chat.routes");

app.use("/", authenticateToken, chatRoutes); // appointment routes

var appointmentRoutes = require("./routes/appintment.routes");

app.use("/", authenticateToken, appointmentRoutes);
app.use(cors({
  origin: "http://localhost:3000"
})); //Listening on server port and logging status

var PORT = process.env.PORT;
app.listen(PORT, function () {
  console.log("Server listining on PORT: ", PORT);
  connectToMongoDB();
});
//# sourceMappingURL=index.dev.js.map
