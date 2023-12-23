const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const userProfileSchema = new mongoose.Schema(
  {
    DOB: {
      type: Date,
      required: true,
    },
    Gender: {
      type: String,
      enum: ["Male", "Female", "Other"],
      required: true,
    },
    Address: {
      type: String,
      required: true,
      trim: true,
    },
    BloodGroup: String,
    Weight: Number,
    Height: Number,
    MedicalHistoryID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "MedicalHistory",
    },
  },
  { _id: false }
);

const medicationReminderSchema = new mongoose.Schema({
  MedicationName: {
    type: String,
    required: true,
  },
  Dosage: {
    type: String,
    required: true,
  },
  Frequency: {
    type: String,
    required: true,
  },
  StartDate: Date,
  EndDate: Date,
});

const userTypeSchema = new mongoose.Schema({
  TypeName: {
    type: String,
    required: true,
    enum: ["Patient", "Doctor", "Pharmacy"],
  },
});

const userSchema = new mongoose.Schema({
  UserType: userTypeSchema, // Embed UserType schema
  Username: {
    type: String,
    required: true,
    uniqu: true,
    trim: true,
    minlength: 1,
    maxlength: 25,
  },
  Password: {
    type: String,
    required: true,
    maxlength: 25,
  },
  Profile: userProfileSchema,
  ProfilePicture: {
    type: Buffer, // Blob in SQL is typically represented as a Buffer in Mongoose
    default: null,
  },
  MedicationReminders: [medicationReminderSchema],
  Phone: {
    type: String,
    maxlength: 255,
    default: null,
    required: true,
  },
  Email: {
    type: String,
    required: true,
    maxlength: 255,
    default: null,
  },
  FirstName: {
    type: String,
    required: true,
    minlength: 10,
  },
  LastName: {
    type: String,
    required: true,
    minlength: 10,
  },
});

userSchema.pre(
  "save",
  async function (next) {
    try {
      const salt = await bcrypt.genSalt(10);
      this.Password = await bcrypt.hash(this.Password, salt);
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

const User = mongoose.model("User", userSchema);

module.exports = User;
