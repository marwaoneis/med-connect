"use strict";

var Prescription = require("./../models/prescription.model"); // Create a new prescription


var createPrescription = function createPrescription(req, res) {
  var prescription;
  return regeneratorRuntime.async(function createPrescription$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          prescription = new Prescription(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(prescription.save());

        case 4:
          res.status(201).json(prescription);
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
}; // Get all prescriptions


var getAllPrescriptions = function getAllPrescriptions(req, res) {
  var prescriptions;
  return regeneratorRuntime.async(function getAllPrescriptions$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(Prescription.find());

        case 3:
          prescriptions = _context2.sent;
          res.status(200).json(prescriptions);
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
}; // Get a single prescription by ID


var getPrescriptionById = function getPrescriptionById(req, res) {
  var prescription;
  return regeneratorRuntime.async(function getPrescriptionById$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(Prescription.findById(req.params.id));

        case 3:
          prescription = _context3.sent;

          if (prescription) {
            _context3.next = 6;
            break;
          }

          return _context3.abrupt("return", res.status(404).json({
            error: "Prescription not found"
          }));

        case 6:
          res.status(200).json(prescription);
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
}; // Update a prescription by ID


var updatePrescriptionById = function updatePrescriptionById(req, res) {
  var prescription;
  return regeneratorRuntime.async(function updatePrescriptionById$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(Prescription.findByIdAndUpdate(req.params.id, req.body, {
            "new": true
          }));

        case 3:
          prescription = _context4.sent;

          if (prescription) {
            _context4.next = 6;
            break;
          }

          return _context4.abrupt("return", res.status(404).json({
            error: "Prescription not found"
          }));

        case 6:
          res.status(200).json(prescription);
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
}; // Delete a prescription by ID


var deletePrescriptionById = function deletePrescriptionById(req, res) {
  var prescription;
  return regeneratorRuntime.async(function deletePrescriptionById$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Prescription.findByIdAndDelete(req.params.id));

        case 3:
          prescription = _context5.sent;

          if (prescription) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Prescription not found"
          }));

        case 6:
          res.status(204).json(); // No content

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
}; // Get prescriptions by patientId


var getPrescriptionsByPatientId = function getPrescriptionsByPatientId(req, res) {
  var prescriptions;
  return regeneratorRuntime.async(function getPrescriptionsByPatientId$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(Prescription.find({
            patientId: req.params.patientId
          }));

        case 3:
          prescriptions = _context6.sent;
          res.status(200).json(prescriptions);
          _context6.next = 10;
          break;

        case 7:
          _context6.prev = 7;
          _context6.t0 = _context6["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 10:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get prescriptions by doctorId


var getPrescriptionsByDoctorId = function getPrescriptionsByDoctorId(req, res) {
  var prescriptions;
  return regeneratorRuntime.async(function getPrescriptionsByDoctorId$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          _context7.next = 3;
          return regeneratorRuntime.awrap(Prescription.find({
            doctorId: req.params.doctorId
          }));

        case 3:
          prescriptions = _context7.sent;
          res.status(200).json(prescriptions);
          _context7.next = 10;
          break;

        case 7:
          _context7.prev = 7;
          _context7.t0 = _context7["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 10:
        case "end":
          return _context7.stop();
      }
    }
  }, null, null, [[0, 7]]);
};

module.exports = {
  createPrescription: createPrescription,
  getAllPrescriptions: getAllPrescriptions,
  getPrescriptionById: getPrescriptionById,
  updatePrescriptionById: updatePrescriptionById,
  deletePrescriptionById: deletePrescriptionById,
  getPrescriptionsByPatientId: getPrescriptionsByPatientId,
  getPrescriptionsByDoctorId: getPrescriptionsByDoctorId
};
//# sourceMappingURL=prescription.controller.dev.js.map
