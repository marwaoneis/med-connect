const mongoose = require("mongoose");

const locationSchema = new mongoose.Schema(
  {
    ProviderName: {
      type: String,
      trim: true,
      required: true,
    },
    Address: {
      type: String,
      trim: true,
      required: true,
    },
    Email: {
      type: String,
      trim: true,
      required: true,
    },
    Phone: {
      type: String,
      trim: true,
      required: true,
    },
  },
  { timestamps: true }
);

const Location = mongoose.model("Location", locationSchema);

module.exports = Location;
