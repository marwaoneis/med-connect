const mongoose = require("mongoose");

const medicineGroupSchema = new mongoose.Schema({
  pharmacyId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Pharmacy",
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
});

const medicineDetailsSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    sideEffects: {
      type: String,
      required: true,
    },
    group: {
      type: medicineGroupSchema,
      required: true,
    },
  },
  { timestamps: true }
);

const medicineSchema = new mongoose.Schema(
  {
    pharmacyId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Pharmacy",
      required: true,
    },
    medicineDetails: [medicineDetailsSchema],
    stockLevel: {
      type: Number,
      required: true,
    },
    price: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Medicine", medicineSchema);
