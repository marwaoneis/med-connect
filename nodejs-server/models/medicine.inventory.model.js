const mongoose = require("mongoose");

const medicineInventorySchema = new mongoose.Schema(
  {
    MedicineID: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "Medicine",
    },
    PharmacyID: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    Stock: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true }
);

const MedicineInventory = mongoose.model(
  "MedicineInventory",
  medicineInventorySchema
);

module.exports = MedicineInventory;
