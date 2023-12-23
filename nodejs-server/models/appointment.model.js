const mongoose = require("mongoose");

const appointmentSchema = new mongoose.Schema(
  {
    PatientID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    DoctorID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    Date: {
      type: Date,
      required: true,
    },
    Time: {
      type: String,
      required: true,
    },
    Purpose: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

const Appointment = mongoose.model("Appointment", appointmentSchema);

module.exports = Appointment;
