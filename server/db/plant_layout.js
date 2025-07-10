const client = require('./client')
const {v4} = require('uuid')
const uuidv4 = v4

const createPlantLayout = async (plantLayout) => {
   const SQL = `
   INSERT INTO plant_layout (id, plant_id, layout_id, placement)
   VALUES  ($1, $2, $3, $4)
   RETURNING *
   `
   const response = await client.query(SQL,[uuidv4(), plantLayout.plant_id, plantLayout.layout_id, plantLayout.placement])
   return response.rows[0]
}

const fetchPlantLayout = async () => {
    const SQL =`
    SELECT *
    FROM plant_layout
    `
    const response = await client.query(SQL)
    return response.rows
}

const fetchPlantLayoutById = async (id) => {
    const SQL = `
    SELECT *
    FROM plant_layout
    WHERE id = $1
    `
    const response = await client.query(SQL, [id])
    return response.rows[0]
}

module.exports = {
    createPlantLayout,
    fetchPlantLayout,
    fetchPlantLayoutById
}