const Prescription = require("../models/prescription.model");

exports.getAllPrescriptions = async (req, res) => {
  try {
    const prescriptions = await Prescription.find();
    res.json(prescriptions);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.getPrescription = async (req, res) => {
  try {
    const prescription = await Prescription.findById(req.params.id);
    if (!prescription)
      return res.status(404).json({ message: "Prescription not found" });
    res.json(prescription);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.createPrescription = async (req, res) => {
  const prescription = new Prescription(req.body);
  try {
    const newPrescription = await prescription.save();
    res.status(201).json(newPrescription);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

exports.updatePrescription = async (req, res) => {
  try {
    const updatePrescription = await Prescription.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    res.json(updatePrescription);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

exports.deletePrescription = async (req, res) => {
  try {
    const prescription = await Prescription.findById(req.params.id);
    if (!prescription)
      return res.status(404).json({ message: "Prescription not found" });
    await prescription.remove();
    res.json({ message: "Deleted Prescription" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
