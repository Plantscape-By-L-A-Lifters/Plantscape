require("dotenv").config(); //load env first
//require('../../env')
const pg = require("pg");

const client = new pg.Client(process.env.DATABASE_URL);

module.exports = client;
