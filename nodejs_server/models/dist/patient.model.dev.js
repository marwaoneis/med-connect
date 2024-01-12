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
    of: mongoose.Schema.Types.Mixed
  },
  role: {
    type: String,
    "default": "Patient"
  }
});
patientSchema.pre("save", function _callee(next) {
  var salt;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          if (this.isModified("password")) {
            _context.next = 2;
            break;
          }

          return _context.abrupt("return", next());

        case 2:
          _context.prev = 2;
          _context.next = 5;
          return regeneratorRuntime.awrap(bcrypt.genSalt(10));

        case 5:
          salt = _context.sent;
          _context.next = 8;
          return regeneratorRuntime.awrap(bcrypt.hash(this.password, salt));

        case 8:
          this.password = _context.sent;
          next();
          _context.next = 16;
          break;

        case 12:
          _context.prev = 12;
          _context.t0 = _context["catch"](2);
          console.log(_context.t0);
          next(_context.t0);

        case 16:
        case "end":
          return _context.stop();
      }
    }
  }, null, this, [[2, 12]]);
}, {
  timestamps: true
});
module.exports = mongoose.model("Patient", patientSchema);
//# sourceMappingURL=patient.model.dev.js.map
