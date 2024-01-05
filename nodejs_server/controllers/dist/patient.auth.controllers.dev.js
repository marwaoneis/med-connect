"use strict";

var _require = require("../utils/auth.utils"),
    generateToken = _require.generateToken,
    sendResponseWithToken = _require.sendResponseWithToken;

var bcrypt = require("bcrypt");

var Patient = require("../models/patient.model");

exports.registerPatient = function _callee(req, res) {
  var patient;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          // Create new patient
          patient = new Patient(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(patient.save());

        case 4:
          // Send response with token
          sendResponseWithToken(patient, 201, res);
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
};

exports.loginPatient = function _callee2(req, res) {
  var _req$body, username, password, patient, isMatch;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          console.log("Received login request for patient");
          _context2.prev = 1;
          _req$body = req.body, username = _req$body.username, password = _req$body.password; // Check if patient exists

          _context2.next = 5;
          return regeneratorRuntime.awrap(Patient.findOne({
            username: username
          }));

        case 5:
          patient = _context2.sent;

          if (patient) {
            _context2.next = 8;
            break;
          }

          return _context2.abrupt("return", res.status(401).json({
            error: "Invalid login credentials"
          }));

        case 8:
          _context2.next = 10;
          return regeneratorRuntime.awrap(bcrypt.compare(password, patient.password));

        case 10:
          isMatch = _context2.sent;

          if (isMatch) {
            _context2.next = 13;
            break;
          }

          return _context2.abrupt("return", res.status(401).json({
            error: "Invalid login credentials"
          }));

        case 13:
          // Send response with token
          sendResponseWithToken(patient, 200, res);
          _context2.next = 19;
          break;

        case 16:
          _context2.prev = 16;
          _context2.t0 = _context2["catch"](1);
          res.status(500).json({
            error: _context2.t0.message
          });

        case 19:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[1, 16]]);
};
//# sourceMappingURL=patient.auth.controllers.dev.js.map
