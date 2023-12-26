"use strict";

var express = require("express");

var router = express.Router();

var medicationOrderController = require("../controllers/medication.order.controller");

router.post("/medication-orders", medicationOrderController.createMedicationOrder);
router.get("/medication-orders/:id", medicationOrderController.getMedicationOrderById);
router.get("/medication-orders/patient/:patientId", medicationOrderController.getMedicationOrdersByPatientId);
router.get("/medication-orders/pharmacy/:pharmacyId", medicationOrderController.getMedicationOrdersByPharmacyId);
router.put("/medication-orders/:id", medicationOrderController.updateMedicationOrderById);
router["delete"]("/medication-orders/:id", medicationOrderController.deleteMedicationOrderById);
module.exports = router;
//# sourceMappingURL=medication.order.routes.dev.js.map
