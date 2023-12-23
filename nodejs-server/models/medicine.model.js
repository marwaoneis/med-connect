const mongoose = require("mongoose");

const symptomSchema = new mongoose.Schema({
  SymptomDescription: {
    type: String,
    required: true,
  },
  PossibleConditions: String,
});

const medicineSchema = new mongoose.Schema(
  {
    Name: {
      type: String,
      required: true,
      trim: true,
    },
    Description: {
      type: String,
      trim: true,
    },
    Manufacturer: {
      type: String,
      trim: true,
    },
    UseInstructions: {
      type: String,
      trim: true,
    },
    SideEffects: {
      type: String,
      trim: true,
    },
    GroupName: {
      type: String,
      required: true,
      trim: true,
    },
    Symptoms: [symptomSchema],
  },
  { timestamps: true }
);

const Medicine = mongoose.model("Medicine", medicineSchema);

module.exports = Medicine;
