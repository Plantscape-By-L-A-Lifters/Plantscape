const express = require('express')
const app = express.Router()

const {
    createLayout,
    fetchLayouts,
    fetchLayoutsById
} = require('../db/layouts')

app.post('./', async (req, res, next) => {
    try {
        res.send(await createLayout(req.body))
    } catch (error) {
        next(error)
    }
})

app.get('./', async (req, res,next) => {
    try {
        res.send( await fetchLayouts())
    } catch (error) {
        next(error)
    }
})

app.get('./:id', async(req, res, next)=>{
    try {
        res.send( await fetchLayoutsById(id))
    } catch (error) {
        next(error)
    }
})
module.exports = app 