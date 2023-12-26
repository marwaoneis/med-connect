"use strict";

var express = require("express");

var router = express.Router();

var medicineController = require("../controllers/medicine.controller");

router.post("/medicines", medicineController.createMedicine);
router.get("/medicines/bypharmacy/:pharmacyId", medicineController.getMedicinesByPharmacyId);
router.get("/medicines/:id", medicineController.getMedicineById);
router.put("/medicines/:id", medicineController.updateMedicineById);
router["delete"]("/medicines/:id", medicineController.deleteMedicineById);
module.exports = router;
//# sourceMappingURL=medicine.routes.dev.js.map
