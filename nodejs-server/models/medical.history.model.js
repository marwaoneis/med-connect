const mongoose = require("mongoose");

const medicalHistorySchema = new mongoose.Schema(
  {
    UserID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    Vaccinations: {
      type: [String],
      default: [],
    },
    Allergies: {
      type: [String],
      default: [],
    },
    PriorSurgeries: {
      type: [String],
      default: [],
    },
    EmergencyContacts: {
      type: [
        {
          name: String,
          phone: String,
          relation: String,
        },
      ],
      default: [],
    },
    CurrentMedications: {
      type: [String],
      default: [],
    },
  },
  { timestamps: true }
);

const MedicalHistory = mongoose.model("MedicalHistory", medicalHistorySchema);

module.exports = MedicalHistory;
