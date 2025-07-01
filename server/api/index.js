const express = require('express')
const app = express.Router()

app.use('/users', require('./users'))
app.use('/plants', require('./plants'))

module.exports = app 