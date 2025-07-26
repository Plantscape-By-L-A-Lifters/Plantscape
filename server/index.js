require("dotenv").config(); // MUST be at the very top!
const { client, seed } = require("./db");

const express = require("express");
const app = express();
app.use(express.json());
app.use("/api", require("./api"));

const init = async () => {
  const PORT = process.env.PORT || 3000;
  await client.connect();
  console.log("connected to database");

  // Now call seed *without* it connecting/disconnecting itself
  // Pass false to indicate the connection is already managed by Server/index.js
  await seed(false); // Pass false so it doesn't try to connect/disconnect again

  app.listen(PORT, () => {
    console.log(`listening on port ${PORT}`);
  });
};
init();
