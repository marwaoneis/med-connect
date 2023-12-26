"use strict";

var mongoose = require("mongoose");

var prescriptionSchema = new mongoose.Schema({
  patientId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Patient",
    required: true
  },
  doctorId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Doctor",
    required: true
  },
  medicineName: {
    type: String,
    required: true
  },
  dosageInstructions: {
    type: String,
    required: true
  }
}, {
  timestamps: true
});
module.exports = mongoose.model("Prescription", prescriptionSchema);
//# sourceMappingURL=prescription.model.dev.js.map
