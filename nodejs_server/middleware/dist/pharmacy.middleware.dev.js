"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var pharmacyMiddleware = function pharmacyMiddleware(req, res, next) {
  var user = req.user;

  if (user.role == "Pharmacy") {
    next();
  } else {
    res.status(401).message("Unothurized");
  }
};

var _default = pharmacyMiddleware;
exports["default"] = _default;
//# sourceMappingURL=pharmacy.middleware.dev.js.map
