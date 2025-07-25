require("dotenv").config(); // MUST be at the very top!
const { client, seed } = require("./db");

try {
  require("../env");
} catch (error) {
  console.log("make env file locally");
}

const express = require("express");
const app = express();
app.use(express.json());
app.use("/api", require("./api"));

const init = async () => {
  const PORT = process.env.PORT || 3000;
  await client.connect();
  seed();
  console.log("connected to database");
  app.listen(PORT, () => {
    console.log(`listening on port ${PORT}`);
  });
};
init();
