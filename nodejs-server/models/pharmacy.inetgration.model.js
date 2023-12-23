const mongoose = require("mongoose");

const pharmacyIntegrationSchema = new mongoose.Schema(
  {
    PharmacyID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    MedicineID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Medicine",
      required: true,
    },
    StockLevel: {
      type: Number,
      required: true,
    },
    RefillInformation: {
      type: String,
      maxlength: 1000,
    },
  },
  { timestamps: true }
);

const PharmacyIntegration = mongoose.model(
  "PharmacyIntegration",
  pharmacyIntegrationSchema
);

module.exports = PharmacyIntegration;
