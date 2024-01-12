"use strict";

var pharmacyMiddleware = function pharmacyMiddleware(req, res, next) {
  var user = req.user;

  if (user.role == "Pharmacy") {
    next();
  } else {
    res.status(401).message("Unothurized");
  }
};

module.exports = {
  pharmacyMiddleware: pharmacyMiddleware
};
//# sourceMappingURL=pharmacy.middleware.dev.js.map
