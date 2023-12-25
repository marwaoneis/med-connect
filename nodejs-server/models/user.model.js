const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcrypt");

const userSchema = new mongoose.Schema({
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
  userType: {
    type: String,
    enum: ["Patient", "Doctor", "Pharmacy"],
  },
  profileInfoId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "ProfileInfo",
  },
});

userSchema.pre(
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

module.exports = mongoose.model("User", userSchema);
