const express = require('express')
const app = express.Router()

const {
    createProject,
    fetchProject,
    fetchMyProject
}= require('../db/Projects')

const { 
    isLoggedIn
} = require('./middleware')

app.post('/', isLoggedIn, async (req, res, next ) => {
    try {
        res.send(await createProject(req.body))
    } catch (error) {
        next(error)
    }
})

app.get('/Projects', async (req, res, next) => { 
    try {
        res.send(await fetchProject())
    } catch (error) {
        next(error)
    }
})

app.get('/MyProjects/:id', async (req, res, next) => { 
    try {
        res.send(await fetchMyProject(req.params.id))
    } catch (error) {
        next(error)
    }
})

module.exports = app