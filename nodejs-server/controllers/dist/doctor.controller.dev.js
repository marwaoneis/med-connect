"use strict";

var Doctor = require("./../models/doctor.model"); // Create a new doctor


var createDoctor = function createDoctor(req, res) {
  var doctor;
  return regeneratorRuntime.async(function createDoctor$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          doctor = new Doctor(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(doctor.save());

        case 4:
          res.status(201).json(doctor);
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          res.status(400).json({
            error: _context.t0.message
          });

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get all doctors


var getAllDoctors = function getAllDoctors(req, res) {
  var doctors;
  return regeneratorRuntime.async(function getAllDoctors$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(Doctor.find());

        case 3:
          doctors = _context2.sent;
          res.status(200).json(doctors);
          _context2.next = 10;
          break;

        case 7:
          _context2.prev = 7;
          _context2.t0 = _context2["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 10:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get a single doctor by ID


var getDoctorById = function getDoctorById(req, res) {
  var doctor;
  return regeneratorRuntime.async(function getDoctorById$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(Doctor.findById(req.params.id));

        case 3:
          doctor = _context3.sent;

          if (doctor) {
            _context3.next = 6;
            break;
          }

          return _context3.abrupt("return", res.status(404).json({
            error: "Doctor not found"
          }));

        case 6:
          res.status(200).json(doctor);
          _context3.next = 12;
          break;

        case 9:
          _context3.prev = 9;
          _context3.t0 = _context3["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 12:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; // Update a doctor by ID


var updateDoctorById = function updateDoctorById(req, res) {
  var doctor;
  return regeneratorRuntime.async(function updateDoctorById$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(Doctor.findByIdAndUpdate(req.params.id, req.body, {
            "new": true
          }));

        case 3:
          doctor = _context4.sent;

          if (doctor) {
            _context4.next = 6;
            break;
          }

          return _context4.abrupt("return", res.status(404).json({
            error: "Doctor not found"
          }));

        case 6:
          res.status(200).json(doctor);
          _context4.next = 12;
          break;

        case 9:
          _context4.prev = 9;
          _context4.t0 = _context4["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 12:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; // Delete a doctor by ID


var deleteDoctorById = function deleteDoctorById(req, res) {
  var doctor;
  return regeneratorRuntime.async(function deleteDoctorById$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Doctor.findByIdAndDelete(req.params.id));

        case 3:
          doctor = _context5.sent;

          if (doctor) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Doctor not found"
          }));

        case 6:
          res.status(204).json({
            message: "Doctor Deleted"
          });
          _context5.next = 12;
          break;

        case 9:
          _context5.prev = 9;
          _context5.t0 = _context5["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 12:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; // Get doctor by username


var getDoctorByUsername = function getDoctorByUsername(req, res) {
  var doctor;
  return regeneratorRuntime.async(function getDoctorByUsername$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(Doctor.findOne({
            username: req.params.username
          }));

        case 3:
          doctor = _context6.sent;

          if (doctor) {
            _context6.next = 6;
            break;
          }

          return _context6.abrupt("return", res.status(404).json({
            error: "Doctor not found"
          }));

        case 6:
          res.status(200).json(doctor);
          _context6.next = 12;
          break;

        case 9:
          _context6.prev = 9;
          _context6.t0 = _context6["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 12:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 9]]);
};

module.exports = {
  createDoctor: createDoctor,
  getAllDoctors: getAllDoctors,
  getDoctorById: getDoctorById,
  updateDoctorById: updateDoctorById,
  deleteDoctorById: deleteDoctorById,
  getDoctorByUsername: getDoctorByUsername
};
//# sourceMappingURL=doctor.controller.dev.js.map
