const client = require('./client')
const { v4: uuidv4 } = require('uuid');
const 
{
    createUser
} = require('./user');

const {
    createDesign
} = require('./design')

const {
createPlant
} = require('./plants');

const {
    createFavoritePlant
} = require('./favorite_plants')

const {
    createLayout
} = require('./layouts')

const seed = async () => {
    const SQL = `
    DROP TABLE IF EXISTS projects CASCADE;
    DROP TABLE IF EXISTS layouts;
    DROP TABLE IF EXISTS favorite_plants;
    DROP TABLE IF EXISTS plants;
    DROP TABLE IF EXISTS designs;
    DROP TABLE IF EXISTS users;

    CREATE TABLE users(
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    is_admin BOOLEAN DEFAULT false NOT NULL
    );
    
    CREATE TABLE designs(
    id UUID PRIMARY KEY,
    design_style_name VARCHAR(50),
    design_attributes VARCHAR(50)
    );

        CREATE TABLE plants(
    id UUID PRIMARY KEY,
    plant_name VARCHAR(100) NOT NULL,
    plant_type VARCHAR (50) NOT NULL,
    toxic BOOLEAN DEFAULT false NOT NULL,
    design_type UUID REFERENCES designs(id), 
    size INTEGER NOT NULL 
    );

    CREATE TABLE favorite_plants(
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    plant_id UUID REFERENCES plants(id),
    CONSTRAINT user_and_plant_id UNIQUE(user_id, plant_id)
    );

    CREATE TABLE layouts(
    id UUID PRIMARY KEY,
    bedding_size INTEGER NOT NULL,
    design_type UUID REFERENCES designs(id)
    );

    CREATE TABLE projects(
    id UUID PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    user_id UUID REFERENCES users(id),
    layout_id UUID REFERENCES layouts(id),
    project_count INTEGER NOT NULL,
    project_design UUID REFERENCES designs(id)
    );
    `
    await client.query(SQL)

const [Justin,Chelsea,Callen,Ellie] = await Promise.all([
    createUser({id: uuidv4(), username: 'Justin', password: '0710', is_admin:true}),
    createUser({id: uuidv4(), username: 'Chelsea', password: '1234', is_admin:true}),
    createUser({id: uuidv4(), username: 'Callen', password: '5678', is_admin:true}),
    createUser({id: uuidv4(), username: 'Ellie', password: '9012', is_admin:true})
]);

const [Cottage, Modern, Wild ] = await Promise.all([
    createDesign({id: uuidv4(), design_style_name: 'Cottage' , design_attributes: 'Summer'}),
    createDesign({id: uuidv4(), design_style_name: 'Modern' , design_attributes: 'Spring'}),
    createDesign({id: uuidv4(), design_style_name: 'Wild' , design_attributes: 'Fall'})
])

const [Aloe,Fern,Rose] = await Promise.all([
    createPlant({id: uuidv4(), plant_name:'Aloe', plant_type: 'Succulent', toxic:true , design_type: Wild.id, size:10}),
    createPlant({id: uuidv4(), plant_name:'Fern', plant_type: 'Foliage', toxic:false , design_type: Cottage.id ,size:15}),
    createPlant({id: uuidv4(), plant_name:'Rose', plant_type: 'Flower', toxic:false , design_type: Modern.id ,size:12})
]);

await Promise.all([
    createFavoritePlant({id:uuidv4(), user_id: Justin.id , plant_id: Fern.id}),
    createFavoritePlant({id:uuidv4(), user_id: Ellie.id, plant_id: Aloe.id}),
    createFavoritePlant({id:uuidv4(), user_id: Callen.id, plant_id: Aloe.id}),
    createFavoritePlant({id:uuidv4(), user_id: Chelsea.id, plant_id: Rose.id})
])

await Promise.all([
    createLayout({id:uuidv4(), bedding_size: 100, design_type: Cottage.id}),
    createLayout({id:uuidv4(), bedding_size: 450, design_type: Modern.id}),
    createLayout({id:uuidv4(), bedding_size: 210, design_type: Wild.id})
])

console.log('Tables Seeded')
}

module.exports = {
    client,
    seed
}