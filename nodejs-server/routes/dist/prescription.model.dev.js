"use strict";

var express = require("express");

var router = express.Router(); // Import controllers

var prescriptionController = require("../controllers/prescription.controller"); // Prescription routes


router.get("/prescriptions", prescriptionController.getAllPrescriptions);
router.get("/prescriptions/:id", prescriptionController.getPrescription);
router.post("/prescriptions", prescriptionController.createPrescription);
router.put("/prescriptions/:id", prescriptionController.updatePrescription);
router["delete"]("/prescriptions/:id", prescriptionController.deletePrescription);
module.exports = router;
//# sourceMappingURL=prescription.model.dev.js.map
