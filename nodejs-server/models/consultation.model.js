const mongoose = require("mongoose");

const consultationSchema = new mongoose.Schema(
  {
    PatientID: Number,
    DoctorID: Number,
    Date: Date,
    Time: String,
    PlatformDetails: String,
  },
  { timestamps: true }
);

const Consultation = mongoose.model("Consultation", consultationSchema);

module.exports = Consultation;
