"use strict";

var mongoose = require("mongoose");

var messageSchema = new mongoose.Schema({
  senderId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true
  },
  receiverId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true
  },
  content: {
    type: String,
    required: true
  }
}, {
  timestamps: true
});
var chatSchema = new mongoose.Schema({
  patientId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Patient",
    required: true
  },
  doctorId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Doctor",
    required: true
  },
  messages: [messageSchema]
}, {
  timestamps: true
});
module.exports = mongoose.model("Chat", chatSchema);
//# sourceMappingURL=chat.model.dev.js.map
