"use strict";

var Appointment = require("./../models/appointment.model"); // Create a new appointment


var createAppointment = function createAppointment(req, res) {
  var appointment;
  return regeneratorRuntime.async(function createAppointment$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          appointment = new Appointment(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(appointment.save());

        case 4:
          res.status(201).json(appointment);
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
}; // Get a single appointment by ID


var getAppointmentById = function getAppointmentById(req, res) {
  var appointment;
  return regeneratorRuntime.async(function getAppointmentById$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(Appointment.findById(req.params.id));

        case 3:
          appointment = _context2.sent;

          if (appointment) {
            _context2.next = 6;
            break;
          }

          return _context2.abrupt("return", res.status(404).json({
            error: "Appointment not found"
          }));

        case 6:
          res.status(200).json(appointment);
          _context2.next = 12;
          break;

        case 9:
          _context2.prev = 9;
          _context2.t0 = _context2["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 12:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 9]]);
}; // Get all appointments by patientId


var getAppointmentsByPatientId = function getAppointmentsByPatientId(req, res) {
  var appointments;
  return regeneratorRuntime.async(function getAppointmentsByPatientId$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(Appointment.find({
            patientId: req.params.patientId
          }));

        case 3:
          appointments = _context3.sent;
          res.status(200).json(appointments);
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
}; // Get all appointments by doctorId


var getAppointmentsByDoctorId = function getAppointmentsByDoctorId(req, res) {
  var appointments;
  return regeneratorRuntime.async(function getAppointmentsByDoctorId$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(Appointment.find({
            doctorId: req.params.doctorId
          }));

        case 3:
          appointments = _context4.sent;
          res.status(200).json(appointments);
          _context4.next = 10;
          break;

        case 7:
          _context4.prev = 7;
          _context4.t0 = _context4["catch"](0);
          res.status(500).json({
            error: "Internal Server Error"
          });

        case 10:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 7]]);
}; // Update an appointment by ID


var updateAppointmentById = function updateAppointmentById(req, res) {
  var appointment;
  return regeneratorRuntime.async(function updateAppointmentById$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Appointment.findByIdAndUpdate(req.params.id, req.body, {
            "new": true
          }));

        case 3:
          appointment = _context5.sent;

          if (appointment) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Appointment not found"
          }));

        case 6:
          res.status(200).json(appointment);
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
}; // Delete an appointment by ID


var deleteAppointmentById = function deleteAppointmentById(req, res) {
  var appointment;
  return regeneratorRuntime.async(function deleteAppointmentById$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(Appointment.findByIdAndDelete(req.params.id));

        case 3:
          appointment = _context6.sent;

          if (appointment) {
            _context6.next = 6;
            break;
          }

          return _context6.abrupt("return", res.status(404).json({
            error: "Appointment not found"
          }));

        case 6:
          res.status(204).json({
            message: "Pharmacy Deleted"
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
  createAppointment: createAppointment,
  getAppointmentsByPatientId: getAppointmentsByPatientId,
  getAppointmentsByDoctorId: getAppointmentsByDoctorId,
  getAppointmentById: getAppointmentById,
  updateAppointmentById: updateAppointmentById,
  deleteAppointmentById: deleteAppointmentById
};
//# sourceMappingURL=appointment.controller.dev.js.map
