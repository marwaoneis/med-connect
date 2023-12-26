"use strict";

var express = require("express");

var router = express.Router();

var chatController = require("../controllers/chat.controller");

router.post("/chats", chatController.createChat);
router.get("/chats/:id", chatController.getChatById);
router.put("/chats/:id", chatController.updateChatById);
router["delete"]("/chats/:id", chatController.deleteChatById);
router.get("/chats/patient/:patientId/doctor/:doctorId", chatController.getChatByPatientAndDoctor);
router.get("/chats/patient/:patientId", chatController.getChatsByPatientId);
router.get("/chats/doctor/:doctorId", chatController.getChatsByDoctorId);
module.exports = router;
//# sourceMappingURL=chat.routes.dev.js.map
