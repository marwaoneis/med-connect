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
})); // auth route
// const authRoutes = require("./routes/auth.routes");
// app.use("/auth", authRoutes);
// patient routes

var patientRoutes = require("./routes/patient.routes");

app.use("/", patientRoutes); // prescription routes

var prescriptionRoutes = require("./routes/prescription.routes");

app.use("/", prescriptionRoutes); // pharmacy routes

var pharmacyRoutes = require("./routes/pharmacy.routes");

app.use("/", pharmacyRoutes); // medicine routes

var medicineRoutes = require("./routes/medicine.routes");

app.use("/", medicineRoutes); // medication order routes

var medicationOrderRoutes = require("./routes/medication.order.routes");

app.use("/", medicationOrderRoutes); // doctor routes

var doctorRoutes = require("./routes/doctor.routes");

app.use("/", doctorRoutes); // chat routes

var chatRoutes = require("./routes/chat.routes");

app.use("/", chatRoutes); // appointment routes

var appointmentRoutes = require("./routes/appintment.routes");

app.use("/", appointmentRoutes);
app.use(cors({
  origin: "http://localhost:3000"
})); //Listening on server port and logging status

var PORT = process.env.PORT;
app.listen(PORT, function () {
  console.log("Server listining on PORT: ", PORT);
  connectToMongoDB();
});
//# sourceMappingURL=index.dev.js.map
