const express = require('express')
const app = express.Router()

const {
    createFavoritePlant,
    fetchFavoritePlants,
    deleteFavoritePlants
} = require('../db/favorite_plants')

const {
    isLoggedIn
} = require('./middleware')

app.post('/', isLoggedIn, async (req, res, next) => { 
    try {
        res.send( await createFavoritePlant(req.body))
    } catch (error) {
        next(error)
    }
})

app.get('/', isLoggedIn,  async (req, res, next) => {
    try {
        res.send(await fetchFavoritePlants(req.user.id))
    } catch (error) {
        next(error)
    }
})

app.delete('/:favorite_plants_id/user/user_id', isLoggedIn, async (req, res, next) => {
    try {
        await deleteFavoritePlants({id: req.params.favorite_plants_id, user_id: req.params.user_id})
        res.sendStatus(204)
    } catch (error) {
        next(error)
    }
})

module.exports = app;