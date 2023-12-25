"use strict";

var express = require("express");

var router = express.Router(); // Import controllers

var patientController = require("./controllers/patient.controller"); // Patient routes


router.get("/patients", patientController.getAllPatients);
router.get("/patients/:id", patientController.getPatient);
router.post("/patients", patientController.createPatient);
router.put("/patients/:id", patientController.updatePatient);
router["delete"]("/patients/:id", patientController.deletePatient);
module.exports = router;
//# sourceMappingURL=patient.routes.dev.js.map
