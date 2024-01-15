const express = require("express");
const router = express.Router();
const medicineController = require("../controllers/medicine.controller");

router.get("/medicines", medicineController.getAllMedicines);
router.post("/medicines", medicineController.createMedicine);
router.get(
  "/medicines/bypharmacy/:pharmacyId",
  medicineController.getMedicinesByPharmacyId
);
router.get("/medicines/:id", medicineController.getMedicineById);
router.put("/medicines/:id", medicineController.updateMedicineById);
router.delete("/medicines/:id", medicineController.deleteMedicineById);

module.exports = router;
