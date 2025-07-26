<<<<<<< HEAD
=======
//require("dotenv").config(); //load env first
//require('../../env')
>>>>>>> origin/main
const pg = require("pg");

const client = new pg.Client(process.env.DATABASE_URL);

module.exports = client;
