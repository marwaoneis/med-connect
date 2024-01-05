"use strict";

var Pharmacy = require("./../models/pharmacy.model"); // Create a new pharmacy


var createPharmacy = function createPharmacy(req, res) {
  var pharmacy;
  return regeneratorRuntime.async(function createPharmacy$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          pharmacy = new Pharmacy(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(pharmacy.save());

        case 4:
          res.status(201).json(pharmacy);
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
}; // Get all pharmacies


var getAllPharmacies = function getAllPharmacies(req, res) {
  var pharmacies;
  return regeneratorRuntime.async(function getAllPharmacies$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(Pharmacy.find());

        case 3:
          pharmacies = _context2.sent;
          res.status(200).json(pharmacies);
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
}; // Get a single pharmacy by ID


var getPharmacyById = function getPharmacyById(req, res) {
  var pharmacy;
  return regeneratorRuntime.async(function getPharmacyById$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(Pharmacy.findById(req.params.id));

        case 3:
          pharmacy = _context3.sent;

          if (pharmacy) {
            _context3.next = 6;
            break;
          }

          return _context3.abrupt("return", res.status(404).json({
            error: "Pharmacy not found"
          }));

        case 6:
          res.status(200).json(pharmacy);
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
}; // Update a pharmacy by ID


var updatePharmacyById = function updatePharmacyById(req, res) {
  var pharmacyId, updateData, pharmacy, updatedPharmacy;
  return regeneratorRuntime.async(function updatePharmacyById$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          pharmacyId = req.params.id;
          updateData = req.body;
          _context4.next = 5;
          return regeneratorRuntime.awrap(Pharmacy.findById(pharmacyId));

        case 5:
          pharmacy = _context4.sent;

          if (pharmacy) {
            _context4.next = 8;
            break;
          }

          return _context4.abrupt("return", res.status(404).json({
            error: "Pharmacy not found"
          }));

        case 8:
          if (updateData.username) pharmacy.username = updateData.username;
          if (updateData.password) pharmacy.password = updateData.password;
          if (updateData.address) pharmacy.address = updateData.address;
          if (updateData.phone) pharmacy.phone = updateData.phone;
          _context4.next = 14;
          return regeneratorRuntime.awrap(pharmacy.save());

        case 14:
          updatedPharmacy = _context4.sent;
          res.status(200).json(updatedPharmacy);
          _context4.next = 21;
          break;

        case 18:
          _context4.prev = 18;
          _context4.t0 = _context4["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 21:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 18]]);
}; // Delete a pharmacy by ID


var deletePharmacyById = function deletePharmacyById(req, res) {
  var pharmacy;
  return regeneratorRuntime.async(function deletePharmacyById$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Pharmacy.findByIdAndDelete(req.params.id));

        case 3:
          pharmacy = _context5.sent;

          if (pharmacy) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Pharmacy not found"
          }));

        case 6:
          res.status(200).json({
            message: "Pharmacy Deleted"
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
}; // Get pharmacy by username


var getPharmacyByUsername = function getPharmacyByUsername(req, res) {
  var pharmacy;
  return regeneratorRuntime.async(function getPharmacyByUsername$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(Pharmacy.findOne({
            username: req.params.username
          }));

        case 3:
          pharmacy = _context6.sent;

          if (pharmacy) {
            _context6.next = 6;
            break;
          }

          return _context6.abrupt("return", res.status(404).json({
            error: "Pharmacy not found"
          }));

        case 6:
          res.status(200).json(pharmacy);
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
}; // Get pharmacies by address


var getPharmaciesByAddress = function getPharmaciesByAddress(req, res) {
  var pharmacies;
  return regeneratorRuntime.async(function getPharmaciesByAddress$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          _context7.next = 3;
          return regeneratorRuntime.awrap(Pharmacy.find({
            address: req.params.address
          }));

        case 3:
          pharmacies = _context7.sent;
          res.status(200).json(pharmacies);
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
  createPharmacy: createPharmacy,
  getAllPharmacies: getAllPharmacies,
  getPharmacyById: getPharmacyById,
  updatePharmacyById: updatePharmacyById,
  deletePharmacyById: deletePharmacyById,
  getPharmacyByUsername: getPharmacyByUsername,
  getPharmaciesByAddress: getPharmaciesByAddress
};
//# sourceMappingURL=pharmacy.controller.dev.js.map
