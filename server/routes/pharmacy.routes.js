const express = require("express");
const router = express.Router();
const pharmacyController = require("../controllers/pharmacy.controller");
const { pharmacyMiddleware } = require("../middleware/pharmacy.middleware.js");

router.post(
  "/pharmacies",
  pharmacyMiddleware,
  pharmacyController.createPharmacy
);
router.get("/pharmacies", pharmacyController.getAllPharmacies);
router.get("/pharmacies/:id", pharmacyController.getPharmacyById);
router.put(
  "/pharmacies/:id",
  pharmacyMiddleware,
  pharmacyController.updatePharmacyById
);
router.delete("/pharmacies/:id", pharmacyController.deletePharmacyById);
router.get(
  "/pharmacies/username/:username",
  pharmacyController.getPharmacyByUsername
);
router.get(
  "/pharmacies/address/:address",
  pharmacyController.getPharmaciesByAddress
);

module.exports = router;
