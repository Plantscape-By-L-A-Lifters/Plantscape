const express = require('express')
const app = express.Router()

app.use('/users', require('./users'))
app.use('/plants', require('./plants'))
app.use('./favorite_plants', require('./favorite_plants'))

module.exports = app 