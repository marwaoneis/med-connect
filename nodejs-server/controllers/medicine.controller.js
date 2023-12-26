const Medicine = require("../models/medicine.model");

// Create a new medicine
const createMedicine = async (req, res) => {
  try {
    const medicine = new Medicine(req.body);
    await medicine.save();
    res.status(201).json(medicine);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get all medicines by pharmacyId
const getMedicinesByPharmacyId = async (req, res) => {
  try {
    const medicines = await Medicine.find({
      pharmacyId: req.params.pharmacyId,
    });
    res.status(200).json(medicines);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Get a single medicine by ID
const getMedicineById = async (req, res) => {
  try {
    console.log("Attempting to fetch medicine ID:", req.params.id); // This should be your first console.log
    const medicine = await Medicine.findById(req.params.id);
    if (!medicine) {
      console.log("Medicine not found for ID:", req.params.id);
      return res.status(404).json({ error: "Medicine not found" });
    }
    console.log("Medicine found:", medicine);
    res.status(200).json(medicine);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Update a medicine by ID
const updateMedicineById = async (req, res) => {
  try {
    const medicine = await Medicine.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
    });
    if (!medicine) {
      return res.status(404).json({ error: "Medicine not found" });
    }
    res.status(200).json(medicine);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Delete a medicine by ID
const deleteMedicineById = async (req, res) => {
  try {
    const medicine = await Medicine.findByIdAndDelete(req.params.id);
    if (!medicine) {
      return res.status(404).json({ error: "Medicine not found" });
    }
    res.status(204).json({ message: "Medicine deleted" });
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = {
  createMedicine,
  getMedicineById,
  updateMedicineById,
  deleteMedicineById,
  getMedicinesByPharmacyId,
};
