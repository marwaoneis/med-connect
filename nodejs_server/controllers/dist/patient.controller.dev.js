"use strict";

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

var Patient = require("../models/patient.model"); // Get all patients


var getAllPatients = function getAllPatients(req, res) {
  var patients;
  return regeneratorRuntime.async(function getAllPatients$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(Patient.find());

        case 3:
          patients = _context.sent;
          res.status(200).json(patients);
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get a specific patient by ID


var getPatient = function getPatient(req, res) {
  var patient;
  return regeneratorRuntime.async(function getPatient$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;

          if (!req.params.id) {
            res.status(400).json({
              error: "Bad Request, PatientId Id should be provided"
            });
          }

          _context2.next = 4;
          return regeneratorRuntime.awrap(Patient.findById(req.params.id));

        case 4:
          patient = _context2.sent;

          if (patient) {
            _context2.next = 7;
            break;
          }

          return _context2.abrupt("return", res.status(404).json({
            error: "Patient not found"
          }));

        case 7:
          res.status(200).json(patient);
          _context2.next = 13;
          break;

        case 10:
          _context2.prev = 10;
          _context2.t0 = _context2["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 13:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 10]]);
}; // Create a new patient


var createPatient = function createPatient(req, res) {
  var _req$body, username, password, firstName, lastName, email, address, phone, dateOfBirth, gender, patient;

  return regeneratorRuntime.async(function createPatient$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          // Validate required parameters
          _req$body = req.body, username = _req$body.username, password = _req$body.password, firstName = _req$body.firstName, lastName = _req$body.lastName, email = _req$body.email, address = _req$body.address, phone = _req$body.phone, dateOfBirth = _req$body.dateOfBirth, gender = _req$body.gender;

          if (!(!username || !password || !firstName || !lastName || !email || !address || !phone || !dateOfBirth || !gender)) {
            _context3.next = 4;
            break;
          }

          return _context3.abrupt("return", res.status(400).json({
            error: "All required parameters must be provided"
          }));

        case 4:
          patient = new Patient(req.body);
          _context3.next = 7;
          return regeneratorRuntime.awrap(patient.save());

        case 7:
          res.status(201).json(patient);
          _context3.next = 13;
          break;

        case 10:
          _context3.prev = 10;
          _context3.t0 = _context3["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 13:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 10]]);
}; // Update a patient by ID


var updatePatient = function updatePatient(req, res) {
  var patientId, updateData, patient, updatedPatient;
  return regeneratorRuntime.async(function updatePatient$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          patientId = req.params.id;
          updateData = req.body; // Find the patient document

          _context4.next = 5;
          return regeneratorRuntime.awrap(Patient.findById(patientId));

        case 5:
          patient = _context4.sent;

          if (patient) {
            _context4.next = 8;
            break;
          }

          return _context4.abrupt("return", res.status(404).json({
            error: "Patient not found"
          }));

        case 8:
          if (updateData.username) patient.username = updateData.username;
          if (updateData.password) patient.password = updateData.password;
          if (updateData.firstName) patient.firstName = updateData.firstName;
          if (updateData.lastName) patient.lastName = updateData.lastName;
          if (updateData.email) patient.email = updateData.email;
          if (updateData.address) patient.address = updateData.address;
          if (updateData.phone) patient.phone = updateData.phone;
          if (updateData.dateOfBirth) patient.dateOfBirth = updateData.dateOfBirth;
          if (updateData.gender) patient.gender = updateData.gender; // Save the document

          _context4.next = 19;
          return regeneratorRuntime.awrap(patient.save());

        case 19:
          updatedPatient = _context4.sent;
          res.status(200).json(updatedPatient);
          _context4.next = 26;
          break;

        case 23:
          _context4.prev = 23;
          _context4.t0 = _context4["catch"](0);
          res.status(500).json({
            error: _context4.t0.message
          });

        case 26:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 23]]);
}; // Delete a patient by ID


var deletePatient = function deletePatient(req, res) {
  var patient;
  return regeneratorRuntime.async(function deletePatient$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Patient.findByIdAndDelete(req.params.id));

        case 3:
          patient = _context5.sent;

          if (patient) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Patient not found"
          }));

        case 6:
          res.status(200).json({
            message: "Patient deleted"
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
}; // Insert entry to additional info in a patient by ID


var insertAdditionalInfo = function insertAdditionalInfo(req, res) {
  var _req$body2, key, value, patient;

  return regeneratorRuntime.async(function insertAdditionalInfo$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _req$body2 = req.body, key = _req$body2.key, value = _req$body2.value; // Check if key and value are present for insertion

          if (!(!key || !value)) {
            _context6.next = 4;
            break;
          }

          return _context6.abrupt("return", res.status(400).json({
            error: "Both key and value must be provided for insertion"
          }));

        case 4:
          _context6.next = 6;
          return regeneratorRuntime.awrap(Patient.findByIdAndUpdate(req.params.id, {
            $set: _defineProperty({}, "additionalInfo.".concat(key), value)
          }, // Use $set to insert the key-value pair
          {
            "new": true
          }));

        case 6:
          patient = _context6.sent;

          if (patient) {
            _context6.next = 9;
            break;
          }

          return _context6.abrupt("return", res.status(404).json({
            error: "Patient not found"
          }));

        case 9:
          res.status(200).json(patient);
          _context6.next = 15;
          break;

        case 12:
          _context6.prev = 12;
          _context6.t0 = _context6["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 15:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 12]]);
}; // Delete entry from additional info in a patient by ID


var deleteAdditionalInfo = function deleteAdditionalInfo(req, res) {
  var key, patient;
  return regeneratorRuntime.async(function deleteAdditionalInfo$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          key = req.params.key; // Check if key is present for deletion

          if (key) {
            _context7.next = 4;
            break;
          }

          return _context7.abrupt("return", res.status(400).json({
            error: "Key must be provided for deletion"
          }));

        case 4:
          _context7.next = 6;
          return regeneratorRuntime.awrap(Patient.findByIdAndUpdate(req.params.id, {
            $unset: _defineProperty({}, "additionalInfo.".concat(key), 1)
          }, // Use $unset to delete the key-value pair
          {
            "new": true
          }));

        case 6:
          patient = _context7.sent;

          if (patient) {
            _context7.next = 9;
            break;
          }

          return _context7.abrupt("return", res.status(404).json({
            error: "Patient not found"
          }));

        case 9:
          res.status(200).json(patient);
          _context7.next = 15;
          break;

        case 12:
          _context7.prev = 12;
          _context7.t0 = _context7["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 15:
        case "end":
          return _context7.stop();
      }
    }
  }, null, null, [[0, 12]]);
};

module.exports = {
  getAllPatients: getAllPatients,
  getPatient: getPatient,
  createPatient: createPatient,
  updatePatient: updatePatient,
  deletePatient: deletePatient,
  insertAdditionalInfo: insertAdditionalInfo,
  deleteAdditionalInfo: deleteAdditionalInfo
};
//# sourceMappingURL=patient.controller.dev.js.map
