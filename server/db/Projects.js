const client = require('./client')
const {v4} = require ('uuid')
const uuidv4 = v4

const createProject = async (project) => {
    const SQL = `
    INSERT INTO projects (id, project_name, user_id)
    VALUES ($1, $2, $3)
    RETURNING *
    `
    const response = await client.query(SQL,[uuidv4(), project.project_name, project.user_id])
    return response.rows[0]
}

const fetchProject = async () => {
    const SQL =`
    SELECT * 
    FROM projects
    `
    const response = await client.query(SQL)
    return response.rows
}

const fetchMyProject = async (id) => {
    const SQL =`
    SELECT * 
    FROM projects
    WHERE user_id = $1
    `
    const response = await client.query(SQL,[id])
    return response.rows[0]
}

module.exports ={
    createProject,
    fetchProject,
    fetchMyProject
}