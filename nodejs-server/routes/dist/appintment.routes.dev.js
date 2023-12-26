"use strict";

var express = require("express");

var router = express.Router();

var appointmentController = require("../controllers/appointment.controller");

router.post("/appointments", appointmentController.createAppointment);
router.get("/appointments/:id", appointmentController.getAppointmentById);
router.put("/appointments/:id", appointmentController.updateAppointmentById);
router["delete"]("/appointments/:id", appointmentController.deleteAppointmentById);
router.get("/appointments/patient/:patientId", appointmentController.getAppointmentsByPatientId);
router.get("/appointments/doctor/:doctorId", appointmentController.getAppointmentsByDoctorId);
module.exports = router;
//# sourceMappingURL=appintment.routes.dev.js.map
