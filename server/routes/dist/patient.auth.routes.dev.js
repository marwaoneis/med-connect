"use strict";

var express = require("express");

var router = express.Router();

var _require = require("../controllers/patient.auth.controllers"),
    registerPatient = _require.registerPatient,
    loginPatient = _require.loginPatient;

router.post("/register", registerPatient);
router.post("/login", loginPatient);
module.exports = router;
//# sourceMappingURL=patient.auth.routes.dev.js.map
