const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcrypt");

const patientSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
    minlength: 3,
    maxlength: 30,
    trim: true,
  },
  password: {
    type: String,
    required: true,
    minlength: 6,
  },
  firstName: {
    type: String,
    required: true,
    minlength: 2,
  },
  lastName: {
    type: String,
    required: true,
    minlength: 2,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    validate: [validator.isEmail, "Please provide a valid email"],
  },
  address: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
  },
  dateOfBirth: {
    type: Date,
    required: true,
  },
  gender: {
    type: String,
    enum: ["Female", "Male"],
  },
  additionalInfo: {
    type: Map,
    of: String, // or mongoose.Schema.Types.Mixed if the structure is not consistent
  },
});

patientSchema.pre(
  "save",
  async function (next) {
    try {
      const salt = await bcrypt.genSalt(10);
      this.password = await bcrypt.hash(this.password, salt);
      next();
    } catch (error) {
      console.log(error);
      next(error);
    }
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Patient", patientSchema);
