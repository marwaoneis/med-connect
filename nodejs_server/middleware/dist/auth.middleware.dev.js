"use strict";

var jwt = require("jsonwebtoken");

var authenticateToken = function authenticateToken(req, res, next) {
  var authHeader = req.headers["authorization"];
  var token = authHeader && authHeader.split(" ")[1];
  if (token == null) return res.sendStatus(401);
  jwt.verify(token, process.env.JWT_SECRET, function (err, user) {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
};

module.exports = {
  authenticateToken: authenticateToken
};
//# sourceMappingURL=auth.middleware.dev.js.map
