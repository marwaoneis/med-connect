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

var authRoutes = require("./routes/auth.routes");

app.use("/auth", authRoutes); // patient routes

var patientRoutes = require("./routes/patient.routes");

app.use("/patient", patientRoutes);
app.use(cors({
  origin: "http://localhost:3000"
})); //Listening on server port and logging status

app.listen(process.env.PORT, function () {
  console.log("Server listining on PORT: ", process.env.PORT);
  connectToMongoDB();
});
//# sourceMappingURL=index.dev.js.map
