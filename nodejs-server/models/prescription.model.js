const mongoose = require("mongoose");

const prescriptionSchema = new mongoose.Schema(
  {
    DoctorID: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    PatientID: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    MedicationID: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "Medication",
    },
    Dosage: {
      type: String,
      required: true,
    },
    Frequency: {
      type: String,
      required: true,
    },
    Duration: {
      type: Number,
      required: true,
    },
    PharmacyID: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
  },
  { timestamps: true }
);

const Prescription = mongoose.model("Prescription", prescriptionSchema);

module.exports = Prescription;
