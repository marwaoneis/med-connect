"use strict";

var connectToMongoDB = function connectToMongoDB() {
  mogoose.connect(process.env.MONGODB_URI || "mongodb://127.0.0.1:27017/medconnect_db");
  var connection = mongoose.connection;
  connection.on("error", function (error) {
    console.log("Error connection to MongoDB: ", error);
  });
  connection.once("open", function () {
    console.log("Connected to MongoDB...");
  });
};

module.exports = {
  connectToMongoDB: connectToMongoDB
};
//# sourceMappingURL=mongoDb.config.dev.js.map
