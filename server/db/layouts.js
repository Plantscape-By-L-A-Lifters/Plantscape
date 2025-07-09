const client = require('./client')
const {v4} = require('uuid')
const uuidv4 = v4

const createLayout = async (layout) => {
    const SQL = `
    INSERT INTO layouts (id, bedding_size, design_type)
    VALUES ($1, $2, $3)
    RETURNING *
    `
    const response = await client.query(SQL, [uuidv4(), layout.bedding_size, layout.design_type])
    return response.rows[0]
}

const fetchLayouts = async () => {
    const SQL = `
    SELECT * 
    FROM layouts
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