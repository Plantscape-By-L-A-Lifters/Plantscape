const express = require('express')
express = express.Router()

const {
    createDesign,
    fetchDesign,
    fetchDesignById
} = require('../db/design')
const app = require('.')

app.post('./', async (req, res, next ) => {
    try {
        res.send(await createDesign(req.body))
    } catch (error) {
        next(error)
    }
})

app.get('./', async (req, res, next) => {
    try {
        res.send(await fetchDesign())
    } catch (error) {
        next(error)
    }
})

app.get('./:id', async (req, res, next) => {
    try {
        res.send(fetchDesignById(req.params.id))
    } catch (error) {
        next(error)
    }
})

module.exports = app