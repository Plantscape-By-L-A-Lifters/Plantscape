const pg = require('pg')
const client = new pg.Client(process.env.DATABASE_URL || 'postgres://artma:postgres@localhost/plantscape_db');

module.exports = client;