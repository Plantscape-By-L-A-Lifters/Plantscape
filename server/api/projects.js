const express = require('express')
const app = express.Router()

const {
    createProject,
    fetchProject
}= require('../db/Projects')

app.post('/projects', async (req, res, next ) => {
    try {
        res.send(await createProject(req.body))
    } catch (error) {
        next(error)
    }
})

app.get('/', async (req, res, next) => {
    try {
        res.send(await fetchProject())
    } catch (error) {
        next(error)
    }
})

module.exports = app