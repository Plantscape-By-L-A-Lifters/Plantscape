require("dotenv").config(); //load env first

const pg = require("pg");
const client = new pg.Client({
  connectionString: process.env.DATABASE_URL,
});

module.exports = client;
