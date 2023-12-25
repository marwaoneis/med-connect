"use strict";

var mongoose = require("mongoose");

var validator = require("validator");

var bcrypt = require("bcrypt");

var patientSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
    minlength: 3,
    maxlength: 30,
    trim: true
  },
  password: {
    type: String,
    required: true,
    minlength: 6
  },
  firstName: {
    type: String,
    required: true,
    minlength: 2
  },
  lastName: {
    type: String,
    required: true,
    minlength: 2
  },
  email: {
    type: String,
    required: true,
    unique: true,
    validate: [validator.isEmail, "Please provide a valid email"]
  },
  address: {
    type: String,
    required: true
  },
  phone: {
    type: String,
    required: true
  },
  dateOfBirth: {
    type: Date,
    required: true
  },
  gender: {
    type: String,
    "enum": ["Female", "Male"]
  },
  additionalInfo: {
    type: Map,
    of: String // or mongoose.Schema.Types.Mixed if the structure is not consistent

  }
});
patientSchema.pre("save", function _callee(next) {
  var salt;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(bcrypt.genSalt(10));

        case 3:
          salt = _context.sent;
          _context.next = 6;
          return regeneratorRuntime.awrap(bcrypt.hash(this.password, salt));

        case 6:
          this.password = _context.sent;
          next();
          _context.next = 14;
          break;

        case 10:
          _context.prev = 10;
          _context.t0 = _context["catch"](0);
          console.log(_context.t0);
          next(_context.t0);

        case 14:
        case "end":
          return _context.stop();
      }
    }
  }, null, this, [[0, 10]]);
}, {
  timestamps: true
});
module.exports = mongoose.model("Patient", patientSchema);
//# sourceMappingURL=patient.model.dev.js.map
