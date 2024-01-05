const Pharmacy = require("./../models/pharmacy.model");

// Create a new pharmacy
const createPharmacy = async (req, res) => {
  try {
    const pharmacy = new Pharmacy(req.body);
    await pharmacy.save();
    res.status(201).json(pharmacy);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get all pharmacies
const getAllPharmacies = async (req, res) => {
  try {
    const pharmacies = await Pharmacy.find();
    res.status(200).json(pharmacies);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Get a single pharmacy by ID
const getPharmacyById = async (req, res) => {
  try {
    const pharmacy = await Pharmacy.findById(req.params.id);
    if (!pharmacy) {
      return res.status(404).json({ error: "Pharmacy not found" });
    }
    res.status(200).json(pharmacy);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Update a pharmacy by ID
const updatePharmacyById = async (req, res) => {
  try {
    const pharmacyId = req.params.id;
    const updateData = req.body;

    const pharmacy = await Pharmacy.findById(pharmacyId);

    if (!pharmacy) {
      return res.status(404).json({ error: "Pharmacy not found" });
    }

    if (updateData.username) pharmacy.username = updateData.username;
    if (updateData.password) pharmacy.password = updateData.password;
    if (updateData.address) pharmacy.address = updateData.address;
    if (updateData.phone) pharmacy.phone = updateData.phone;

    const updatedPharmacy = await pharmacy.save();

    res.status(200).json(updatedPharmacy);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Delete a pharmacy by ID
const deletePharmacyById = async (req, res) => {
  try {
    const pharmacy = await Pharmacy.findByIdAndDelete(req.params.id);
    if (!pharmacy) {
      return res.status(404).json({ error: "Pharmacy not found" });
    }
    res.status(200).json({ message: "Pharmacy Deleted" });
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Get pharmacy by username
const getPharmacyByUsername = async (req, res) => {
  try {
    const pharmacy = await Pharmacy.findOne({ username: req.params.username });
    if (!pharmacy) {
      return res.status(404).json({ error: "Pharmacy not found" });
    }
    res.status(200).json(pharmacy);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Get pharmacies by address
const getPharmaciesByAddress = async (req, res) => {
  try {
    const pharmacies = await Pharmacy.find({ address: req.params.address });
    res.status(200).json(pharmacies);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = {
  createPharmacy,
  getAllPharmacies,
  getPharmacyById,
  updatePharmacyById,
  deletePharmacyById,
  getPharmacyByUsername,
  getPharmaciesByAddress,
};
