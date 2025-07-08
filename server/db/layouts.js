const client = require('./client')
const {v4} = require('uuid')
const uuidv4 = v4

const createLayout = async (layout) => {
    const SQL = `
    INSERT INTO layouts (id, user_id, plant_id, placement)
    VALUES ($1, $2, $3, $4)
    RETURING *
    `
    const response = await client.query(SQL, [uuidv4(), layout.user_id, layout.plant_id, layout.placement])
    return response.rows[0]
}

const fetchLayouts = async () => {
    const SQL = `
    SELECT * 
    FROM layouts
    RETURNING *
    `
    const response = await client.query(SQL)
    return response.rows
}

const fetchLayoutsById = async (id) => {
    const SQL =`
    SELECT *
    FROM layouts
    WHERE id = $1 
    `
    const response = await client.query(SQL, [id])
    return response.rows[0]
}
module.exports ={
    createLayout,
    fetchLayouts,
    fetchLayoutsById
}