const express = require('express')
const app = express.Router()

const {
    createFavoritePlant,
    fetchFavoritePlants,
    deleteFavoritePlants
} = require('../db/favorite_plants')

app.post('/', async (req, res, next) => { // is logged in  
    try {
        res.send( await createFavoritePlant(req.body))
    } catch (error) {
        next(error)
    }
})

app.get('/', async (req, res, next) => {// is logged in 
    try {
        res.send(await fetchFavoritePlants())
    } catch (error) {
        next(error)
    }
})

app.delete('/:favorite_plants_id/user/user_id', async (req, res, next) => {// is logged in
    try {
        await deleteFavoritePlants({id: req.params.favorite_plants_id, user_id: req.params.user_id})
        res.sendStatus(204)
    } catch (error) {
        next(error)
    }
})

module.exports = app;