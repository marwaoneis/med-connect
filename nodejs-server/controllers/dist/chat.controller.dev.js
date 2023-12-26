"use strict";

var Chat = require("./../models/chat.model"); // Create a new chat


var createChat = function createChat(req, res) {
  var chat;
  return regeneratorRuntime.async(function createChat$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          chat = new Chat(req.body);
          _context.next = 4;
          return regeneratorRuntime.awrap(chat.save());

        case 4:
          res.status(201).json(chat);
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
}; // Get a single chat by ID


var getChatById = function getChatById(req, res) {
  var chat;
  return regeneratorRuntime.async(function getChatById$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(Chat.findById(req.params.id));

        case 3:
          chat = _context2.sent;

          if (chat) {
            _context2.next = 6;
            break;
          }

          return _context2.abrupt("return", res.status(404).json({
            error: "Chat not found"
          }));

        case 6:
          res.status(200).json(chat);
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
}; // Update a chat by ID


var updateChatById = function updateChatById(req, res) {
  var chat;
  return regeneratorRuntime.async(function updateChatById$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(Chat.findByIdAndUpdate(req.params.id, req.body, {
            "new": true
          }));

        case 3:
          chat = _context3.sent;

          if (chat) {
            _context3.next = 6;
            break;
          }

          return _context3.abrupt("return", res.status(404).json({
            error: "Chat not found"
          }));

        case 6:
          res.status(200).json(chat);
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
}; // Delete a chat by ID


var deleteChatById = function deleteChatById(req, res) {
  var chat;
  return regeneratorRuntime.async(function deleteChatById$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(Chat.findByIdAndDelete(req.params.id));

        case 3:
          chat = _context4.sent;

          if (chat) {
            _context4.next = 6;
            break;
          }

          return _context4.abrupt("return", res.status(404).json({
            error: "Chat not found"
          }));

        case 6:
          res.status(204).json({
            message: "Chat deleted!"
          });
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
}; // Get chat by patientId and doctorId


var getChatByPatientAndDoctor = function getChatByPatientAndDoctor(req, res) {
  var chat;
  return regeneratorRuntime.async(function getChatByPatientAndDoctor$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _context5.prev = 0;
          _context5.next = 3;
          return regeneratorRuntime.awrap(Chat.findOne({
            patientId: req.params.patientId,
            doctorId: req.params.doctorId
          }));

        case 3:
          chat = _context5.sent;

          if (chat) {
            _context5.next = 6;
            break;
          }

          return _context5.abrupt("return", res.status(404).json({
            error: "Chat not found"
          }));

        case 6:
          res.status(200).json(chat);
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
}; // Get chats by patientId


var getChatsByPatientId = function getChatsByPatientId(req, res) {
  var chats;
  return regeneratorRuntime.async(function getChatsByPatientId$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          _context6.next = 3;
          return regeneratorRuntime.awrap(Chat.find({
            patientId: req.params.patientId
          }));

        case 3:
          chats = _context6.sent;
          res.status(200).json(chats);
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
}; // Get chats by doctorId


var getChatsByDoctorId = function getChatsByDoctorId(req, res) {
  var chats;
  return regeneratorRuntime.async(function getChatsByDoctorId$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          _context7.next = 3;
          return regeneratorRuntime.awrap(Chat.find({
            doctorId: req.params.doctorId
          }));

        case 3:
          chats = _context7.sent;
          res.status(200).json(chats);
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
  createChat: createChat,
  getChatById: getChatById,
  updateChatById: updateChatById,
  deleteChatById: deleteChatById,
  getChatByPatientAndDoctor: getChatByPatientAndDoctor,
  getChatsByPatientId: getChatsByPatientId,
  getChatsByDoctorId: getChatsByDoctorId
};
//# sourceMappingURL=chat.controller.dev.js.map
