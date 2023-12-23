const mongoose = require("mongoose");

const patientSymptomSchema = new mongoose.Schema(
  {
    MedicalHistoryID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "MedicalHistory",
      required: true,
    },
    SymptomID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Medicine",
      required: true,
    },
  },
  { timestamps: true }
);

const PatientSymptom = mongoose.model("PatientSymptom", patientSymptomSchema);

module.exports = PatientSymptom;
