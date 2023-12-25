const express = require("express");
const router = express.Router();

// Import controllers
const patientController = require("./controllers/patient.controller");

// Patient routes
router.get("/patients", patientController.getAllPatients);
router.get("/patients/:id", patientController.getPatient);
router.post("/patients", patientController.createPatient);
router.put("/patients/:id", patientController.updatePatient);
router.delete("/patients/:id", patientController.deletePatient);

module.exports = router;
