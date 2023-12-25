const connectToMongoDB = () => {
  mogoose.connect(
    process.env.MONGODB_URI || "mongodb://127.0.0.1:27017/medconnect_db"
  );
  const connection = mongoose.connection;
  connection.on("error", (error) => {
    console.log("Error connection to MongoDB: ", error);
  });

  connection.once("open", () => {
    console.log("Connected to MongoDB...");
  });
};

module.exports = { connectToMongoDB };
