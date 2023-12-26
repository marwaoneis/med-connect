const express = require('express');
const router = express.Router();
const doctorController = require('./../controllers/doctor.controller');

router.post('/doctors', doctorController.createDoctor);
router.get('/doctors', doctorController.getAllDoctors);
router.get('/doctors/:id', doctorController.getDoctorById);
router.put('/doctors/:id', doctorController.updateDoctorById);
router.delete('/doctors/:id', doctorController.deleteDoctorById);
router.get('/doctors/username/:username', doctorController.getDoctorByUsername);

module.exports = router;
