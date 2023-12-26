"use strict";

var express = require("express");

var router = express.Router();

var pharmacyController = require("../controllers/pharmacy.controller");

router.post("/pharmacies", pharmacyController.createPharmacy);
router.get("/pharmacies", pharmacyController.getAllPharmacies);
router.get("/pharmacies/:id", pharmacyController.getPharmacyById);
router.put("/pharmacies/:id", pharmacyController.updatePharmacyById);
router["delete"]("/pharmacies/:id", pharmacyController.deletePharmacyById);
router.get("/pharmacies/username/:username", pharmacyController.getPharmacyByUsername);
router.get("/pharmacies/address/:address", pharmacyController.getPharmaciesByAddress);
module.exports = router;
//# sourceMappingURL=pharmacy.routes.dev.js.map
