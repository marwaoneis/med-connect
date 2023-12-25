const express = require("express");
const { connectToMongoDB } = require("./config/mongoDb.config");
require("dotenv").config();
const cors = require("cors");

//Initilizing app as express method
const app = express();
app.use(express.json());

app.get("/hello", (req, res) => {
  console.log("HELLO MARWAAAA!!");
});

app.use(cors({ origin: "http://localhost:3000" }));

//Listening on server port and logging status
app.listen(process.env.PORT, () => {
  console.log("Server listining on PORT: ", process.env.PORT);
  connectToMongoDB();
});
