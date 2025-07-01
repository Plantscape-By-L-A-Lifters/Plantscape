const client = require('./client')
const { v4 } = require('uuid')
const uuidv4 = v4

const createDesign = async (design) => {
    const SQL = `
    INSERT INTO designs (id, design_style_name, design_attributes)
    VALUES ($1, $2, $3)
    RETURNING *
    `
    const response = await client.query(SQL, [uuidv4(), design.design_style_name, design.design_attributes])
    return response.rows[0]
}

const fetchDesign = async () => {
    const SQL =  `
    SELECT *
    FROM  design
    `
    const response = await client.query(SQL)
    return response.rows
}

const fetchDesignById = async (id) => {
    const SQL = `
    SELECT *
    FROM design 
    WHERE id = $1
    `
    const response = await client.query(SQL, [id])
    return response.rows[0]
}

module.exports = {
    createDesign,
    fetchDesign,
    fetchDesignById
}