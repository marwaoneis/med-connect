"use strict";

var Medicine = require("../models/medicine.model"); // Create a new medicine


var createMedicine = function createMedicine(req, res) {
  var medicine;
  return regeneratorRuntime.async(function createMedicine$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          medicine = new Medicine(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(medicine.save());

        case 4:
          res.status(201).json(medicine);
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
}; // Get all medicines by pharmacyId


var getMedicinesByPharmacyId = function getMedicinesByPharmacyId(req, res) {
  var medicines;
  return regeneratorRuntime.async(function getMedicinesByPharmacyId$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(Medicine.find({
            pharmacyId: req.params.pharmacyId
          }));

        case 3:
          medicines = _context2.sent;
          res.status(200).json(medicines);
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
}; // Get a single medicine by ID


var getMedicineById = function getMedicineById(req, res) {
  var medicine;
  return regeneratorRuntime.async(function getMedicineById$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          console.log("Attempting to fetch medicine ID:", req.params.id); // This should be your first console.log

          _context3.next = 4;
          return regeneratorRuntime.awrap(Medicine.findById(req.params.id));

        case 4:
          medicine = _context3.sent;

          if (medicine) {
            _context3.next = 8;
            break;
          }

          console.log("Medicine not found for ID:", req.params.id);
          return _context3.abrupt("return", res.status(404).json({
            error: "Medicine not found"
          }));

        case 8:
          console.log("Medicine found:", medicine);
          res.status(200).json(medicine);
          _context3.next = 16;
          break;

        case 12:
          _context3.prev = 12;
          _context3.t0 = _context3["catch"](0);
          console.error(_context3.t0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 16:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 12]]);
}; // Update a medicine by ID


var updateMedicineById = function updateMedicineById(req, res) {
  var medicine;
  return regeneratorRuntime.async(function updateMedicineById$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(Medicine.findByIdAndUpdate(req.params.id, req.body, {
            "new": true
          }));

        case 3:
          medicine = _context4.sent;

          if (medicine) {
            _context4.next = 6;
            break;
          }

          return _context4.abrupt("return", res.status(404).json({
            error: "Medicine not found"
          }));

        case 6:
          res.status(200).json(medicine);
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
}; // Delete a medicine by ID


var deleteMedicineById = function deleteMedicineById(req, res) {
  var medicine;
  return regeneratorRuntime.async(function deleteMedicineById$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Medicine.findByIdAndDelete(req.params.id));

        case 3:
          medicine = _context5.sent;

          if (medicine) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Medicine not found"
          }));

        case 6:
          res.status(204).json({
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
};

module.exports = {
  createMedicine: createMedicine,
  getMedicineById: getMedicineById,
  updateMedicineById: updateMedicineById,
  deleteMedicineById: deleteMedicineById,
  getMedicinesByPharmacyId: getMedicinesByPharmacyId
};
//# sourceMappingURL=medicine.controller.dev.js.map
