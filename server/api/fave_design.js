const express = require('express')
const app = express.Router()

const {
    createFaveDesign,
    fetchFaveDesign
} = require('../db/fave_design')

app.post('./', async (req,res,next) => {
    try {
        res.send( await createFaveDesign(req.body))
    } catch (error) {
        next(error)
    }
})

app.get('./', async (req,res,next) => {
    try {
        res.send( await fetchFaveDesign())
    } catch (error) {
        next(error)
    }
})

module.exports = app