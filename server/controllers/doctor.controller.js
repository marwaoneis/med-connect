const Doctor = require("./../models/doctor.model");

// Create a new doctor
const createDoctor = async (req, res) => {
  try {
    const doctor = new Doctor(req.body);
    await doctor.save();
    res.status(201).json(doctor);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get all doctors
const getAllDoctors = async (req, res) => {
  try {
    const doctors = await Doctor.find();
    res.status(200).json(doctors);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Get a single doctor by ID
const getDoctorById = async (req, res) => {
  try {
    const doctor = await Doctor.findById(req.params.id);
    if (!doctor) {
      return res.status(404).json({ error: "Doctor not found" });
    }
    res.status(200).json(doctor);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

const getSpecializations = async (req, res) => {
  try {
    const specializations = await Doctor.distinct("specialization");
    res.json(specializations);
  } catch (error) {
    res.status(500).send(error);
  }
};

// Update a doctor by ID
const updateDoctorById = async (req, res) => {
  try {
    const doctor = await Doctor.findById(req.params.id);

    if (!doctor) {
      return res.status(404).json({ error: "Doctor not found" });
    }

    const updateData = req.body;
    if (updateData.username) doctor.username = updateData.username;
    if (updateData.password) doctor.password = updateData.password;
    if (updateData.firstName) doctor.firstName = updateData.firstName;
    if (updateData.lastName) doctor.lastName = updateData.lastName;
    if (updateData.email) doctor.email = updateData.email;
    if (updateData.phone) doctor.phone = updateData.phone;
    if (updateData.gender) doctor.gender = updateData.gender;
    if (updateData.specialization)
      doctor.specialization = updateData.specialization;
    if (updateData.yearsOfExperience)
      doctor.yearsOfExperience = updateData.yearsOfExperience;
    if (updateData.appointmentPrice)
      doctor.appointmentPrice = updateData.appointmentPrice;
    if (updateData.timing) doctor.timing = updateData.timing;

    const updatedDoctor = await doctor.save();

    res.status(200).json(updatedDoctor);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Delete a doctor by ID
const deleteDoctorById = async (req, res) => {
  try {
    const doctor = await Doctor.findByIdAndDelete(req.params.id);
    if (!doctor) {
      return res.status(404).json({ error: "Doctor not found" });
    }
    res.status(204).json({ message: "Doctor Deleted" });
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Get doctor by username
const getDoctorByUsername = async (req, res) => {
  try {
    const doctor = await Doctor.findOne({ username: req.params.username });
    if (!doctor) {
      return res.status(404).json({ error: "Doctor not found" });
    }
    res.status(200).json(doctor);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = {
  createDoctor,
  getAllDoctors,
  getDoctorById,
  updateDoctorById,
  deleteDoctorById,
  getSpecializations,
  getDoctorByUsername,
};
