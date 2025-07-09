const client = require('./client')
const {v4} = require('uuid')
const uuidv4= v4

const createPlant = async (plant) => {
    const SQL = `
    INSERT INTO plants(id, plant_name, plant_type, toxic, size)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING *
    `
    const response = await client.query(SQL, [uuidv4(), plant.plant_name, plant.plant_type, plant.toxic, plant.size])
    return response.rows[0]
}

const fetchPlants = async () => {
    const SQL =`
    SELECT *
    FROM plants
    `
    const response = await client.query(SQL)
    return response.rows
}

const fetchPlantsById = async (id) => {
    const SQL = `
    SELECT *
    FROM plants
    WHERE id = $1
    `
    const response = await client.query(SQL, [id])
    return response.rows[0]
}

module.exports = {
    createPlant,
    fetchPlants,
    fetchPlantsById
}