"use strict";

var MedicationOrder = require("../models/medication.order.model"); // Create a new medication order


var createMedicationOrder = function createMedicationOrder(req, res) {
  var medicationOrder;
  return regeneratorRuntime.async(function createMedicationOrder$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          medicationOrder = new MedicationOrder(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(medicationOrder.save());

        case 4:
          res.status(201).json(medicationOrder);
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
}; // Get all medication orders by patientId


var getMedicationOrdersByPatientId = function getMedicationOrdersByPatientId(req, res) {
  var medicationOrders;
  return regeneratorRuntime.async(function getMedicationOrdersByPatientId$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(MedicationOrder.find({
            patientId: req.params.patientId
          }));

        case 3:
          medicationOrders = _context2.sent;
          res.status(200).json(medicationOrders);
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
}; // Get all medication orders by pharmacyId


var getMedicationOrdersByPharmacyId = function getMedicationOrdersByPharmacyId(req, res) {
  var medicationOrders;
  return regeneratorRuntime.async(function getMedicationOrdersByPharmacyId$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(MedicationOrder.find({
            pharmacyId: req.params.pharmacyId
          }));

        case 3:
          medicationOrders = _context3.sent;
          res.status(200).json(medicationOrders);
          _context3.next = 10;
          break;

        case 7:
          _context3.prev = 7;
          _context3.t0 = _context3["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 10:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Get a single medication order by ID


var getMedicationOrderById = function getMedicationOrderById(req, res) {
  var medicationOrder;
  return regeneratorRuntime.async(function getMedicationOrderById$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(MedicationOrder.findById(req.params.id));

        case 3:
          medicationOrder = _context4.sent;

          if (medicationOrder) {
            _context4.next = 6;
            break;
          }

          return _context4.abrupt("return", res.status(404).json({
            error: "Medication Order not found"
          }));

        case 6:
          res.status(200).json(medicationOrder);
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
}; // Update a medication order by ID


var updateMedicationOrderById = function updateMedicationOrderById(req, res) {
  var medicationOrder;
  return regeneratorRuntime.async(function updateMedicationOrderById$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(MedicationOrder.findByIdAndUpdate(req.params.id, req.body, {
            "new": true
          }));

        case 3:
          medicationOrder = _context5.sent;

          if (medicationOrder) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Medication Order not found"
          }));

        case 6:
          res.status(200).json(medicationOrder);
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
}; // Delete a medication order by ID


var deleteMedicationOrderById = function deleteMedicationOrderById(req, res) {
  var medicationOrder;
  return regeneratorRuntime.async(function deleteMedicationOrderById$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(MedicationOrder.findByIdAndDelete(req.params.id));

        case 3:
          medicationOrder = _context6.sent;

          if (medicationOrder) {
            _context6.next = 6;
            break;
          }

          return _context6.abrupt("return", res.status(404).json({
            error: "Medication Order not found"
          }));

        case 6:
          res.status(204).json({
            message: "Order Deleted"
          });
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
  createMedicationOrder: createMedicationOrder,
  getMedicationOrdersByPatientId: getMedicationOrdersByPatientId,
  getMedicationOrdersByPharmacyId: getMedicationOrdersByPharmacyId,
  getMedicationOrderById: getMedicationOrderById,
  updateMedicationOrderById: updateMedicationOrderById,
  deleteMedicationOrderById: deleteMedicationOrderById
};
//# sourceMappingURL=medication.order.controller.dev.js.map
