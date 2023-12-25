const mongoose = require("mongoose");

const AiAssessmentSchema = new mongoose.Schema(
  {
    patientId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Patient",
      required: true,
    },
    symptoms: {
      type: String,
      required: true,
    },
    aiAssessment: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

const appointmentSchema = new mongoose.Schema(
  {
    patientId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Patient",
      required: true,
    },
    doctorId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Doctor",
      required: true,
    },
    dateTime: {
      type: Date,
      required: true,
    },
    aiAssessment: [AiAssessmentSchema],
    status: {
      type: String,
      enum: ["Scheduled", "Completed", "Cancelled"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Appointment", appointmentSchema);
