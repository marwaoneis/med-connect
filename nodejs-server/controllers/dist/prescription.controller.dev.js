"use strict";

var Prescription = require("../models/prescription.model");

exports.getAllPrescriptions = function _callee(req, res) {
  var prescriptions;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(Prescription.find());

        case 3:
          prescriptions = _context.sent;
          res.json(prescriptions);
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          res.status(500).json({
            message: _context.t0.message
          });

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
};

exports.getPrescription = function _callee2(req, res) {
  var prescription;
  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(Prescription.findById(req.params.id));

        case 3:
          prescription = _context2.sent;

          if (prescription) {
            _context2.next = 6;
            break;
          }

          return _context2.abrupt("return", res.status(404).json({
            message: "Prescription not found"
          }));

        case 6:
          res.json(prescription);
          _context2.next = 12;
          break;

        case 9:
          _context2.prev = 9;
          _context2.t0 = _context2["catch"](0);
          res.status(500).json({
            message: _context2.t0.message
          });

        case 12:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 9]]);
};

exports.createPrescription = function _callee3(req, res) {
  var prescription, newPrescription;
  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          prescription = new Prescription(req.body);
          _context3.prev = 1;
          _context3.next = 4;
          return regeneratorRuntime.awrap(prescription.save());

        case 4:
          newPrescription = _context3.sent;
          res.status(201).json(newPrescription);
          _context3.next = 11;
          break;

        case 8:
          _context3.prev = 8;
          _context3.t0 = _context3["catch"](1);
          res.status(400).json({
            message: _context3.t0.message
          });

        case 11:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[1, 8]]);
};

exports.updatePrescription = function _callee4(req, res) {
  var updatePrescription;
  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(Prescription.findByIdAndUpdate(req.params.id, req.body, {
            "new": true
          }));

        case 3:
          updatePrescription = _context4.sent;
          res.json(updatePrescription);
          _context4.next = 10;
          break;

        case 7:
          _context4.prev = 7;
          _context4.t0 = _context4["catch"](0);
          res.status(400).json({
            message: _context4.t0.message
          });

        case 10:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 7]]);
};

exports.deletePrescription = function _callee5(req, res) {
  var prescription;
  return regeneratorRuntime.async(function _callee5$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Prescription.findById(req.params.id));

        case 3:
          prescription = _context5.sent;

          if (prescription) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            message: "Prescription not found"
          }));

        case 6:
          _context5.next = 8;
          return regeneratorRuntime.awrap(prescription.remove());

        case 8:
          res.json({
            message: "Deleted Prescription"
          });
          _context5.next = 14;
          break;

        case 11:
          _context5.prev = 11;
          _context5.t0 = _context5["catch"](0);
          res.status(500).json({
            message: _context5.t0.message
          });

        case 14:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[0, 11]]);
};
//# sourceMappingURL=prescription.controller.dev.js.map
