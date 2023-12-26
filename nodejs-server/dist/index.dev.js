"use strict";

var express = require("express");

var _require = require("./config/mongoDb.config"),
    connectToMongoDB = _require.connectToMongoDB;

require("dotenv").config();

var cors = require("cors"); //Initilizing app as express method


var app = express();
app.use(express.json());
app.get("/hello", function (req, res) {
  console.log("HELLO MARWAAAA!!");
}); // auth route
// const authRoutes = require("./routes/auth.routes");
// app.use("/auth", authRoutes);
// patient routes

var patientRoutes = require("./routes/patient.routes");

app.use("/patient", patientRoutes); // prescription routes

var prescriptionRoutes = require("./routes/prescription.routes");

app.use("/prescription", prescriptionRoutes); // pharmacy routes

var pharmacyRoutes = require("./routes/pharmacy.routes");

app.use("/pharmacy", pharmacyRoutes); // medicine routes

var medicineRoutes = require("./routes/medicine.routes");

app.use("/medicine", medicineRoutes); // medication order routes

var medicationOrderRoutes = require("./routes/medication.order.routes");

app.use("/medication-order", medicationOrderRoutes); // doctor routes

var doctorRoutes = require("./routes/doctor.routes");

app.use("/doctor", doctorRoutes); // chat routes

var chatRoutes = require("./routes/chat.routes");

app.use("/chat", chatRoutes); // appointment routes

var appointmentRoutes = require("./routes/appintment.routes");

app.use("/appointment", appointmentRoutes);
app.use(cors({
  origin: "http://localhost:3000"
})); //Listening on server port and logging status

app.listen(process.env.PORT, function () {
  console.log("Server listining on PORT: ", process.env.PORT);
  connectToMongoDB();
});
//# sourceMappingURL=index.dev.js.map
