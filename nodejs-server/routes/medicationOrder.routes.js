const express = require('express');
const router = express.Router();
const medicationOrderController = require('./../controllers/medicationOrder.controller');

router.post('/medication-orders', medicationOrderController.createMedicationOrder);
router.get('/medication-orders/:id', medicationOrderController.getMedicationOrderById);
router.get('/medication-orders/patient/:patientId', medicationOrderController.getMedicationOrdersByPatientId);
router.get('/medication-orders/pharmacy/:pharmacyId', medicationOrderController.getMedicationOrdersByPharmacyId);
router.put('/medication-orders/:id', medicationOrderController.updateMedicationOrderById);
router.delete('/medication-orders/:id', medicationOrderController.deleteMedicationOrderById);

module.exports = router;
