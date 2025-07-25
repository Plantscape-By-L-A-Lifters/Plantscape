const fs = require("fs").promises; // Add this import for reading seed.sql
const client = require("./client");
const { v4: uuidv4 } = require("uuid");
const { createUser } = require("./user");

const { createDesign } = require("./design");

const { createPlant } = require("./plants");

const { createFavoritePlant } = require("./favorite_plants");

const { createLayout } = require("./layouts");

const { createPlantDesign } = require("./plant_Design_Type");

const { createPlantLayout } = require("./plant_layout");

const { createFaveDesign } = require("./fave_design");

const { createProject } = require("./projects");

const seed = async () => {
  const SQL_SCHEMA = `
    DROP TABLE IF EXISTS projects CASCADE;
    DROP TABLE IF EXISTS plant_layout;
    DROP TABLE IF EXISTS layouts;
    DROP TABLE IF EXISTS favorite_plants;
    DROP TABLE IF EXISTS plant_Design_Types;
    DROP TABLE IF EXISTS fave_design;
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
    design_style_name VARCHAR(50) UNIQUE NOT NULL,
    design_attributes VARCHAR(255)
    );

CREATE TABLE IF NOT EXISTS plants (
    id UUID PRIMARY KEY,
    plant_name VARCHAR(255) UNIQUE NOT NULL, 
    other_common_names TEXT,               
    technical_name VARCHAR(255),           
    growth_form VARCHAR(50),               
    is_toxic BOOLEAN DEFAULT false NOT NULL,
    sun_requirements TEXT,                 
    height_min_ft NUMERIC(5, 2),           
    height_max_ft NUMERIC(5, 2),           
    width_min_ft NUMERIC(5, 2),            
    width_max_ft NUMERIC(5, 2),            
    seasonal_interest TEXT,                
    primary_color VARCHAR(50),             
    accent_color VARCHAR(50),              
    image_url TEXT                         
);

    CREATE TABLE favorite_plants(
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    plant_id UUID REFERENCES plants(id),
    CONSTRAINT user_and_plant_id UNIQUE(user_id, plant_id)
    );

    CREATE TABLE plant_Design_Types(
    id UUID PRIMARY KEY,
    plant_id UUID REFERENCES plants(id),
    design_id UUID REFERENCES designs(id)
    );

    
    CREATE TABLE projects(
    id UUID PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    user_id UUID REFERENCES users(id)
    );

    CREATE TABLE layouts(
    id UUID PRIMARY KEY,
    layout_name varchar(100) NOT NULL,
    bedding_size INTEGER NOT NULL,
    design_type UUID REFERENCES designs(id),
    projects_id UUID REFERENCES projects(id)
    );

    CREATE TABLE plant_layout(
    id UUID PRIMARY KEY,
    plant_id UUID REFERENCES plants(id),
    layout_id UUID REFERENCES layouts(id),
    placement FLOAT
    );

    CREATE TABLE fave_design(
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    design_id UUID REFERENCES designs(id)
    );
    `;

  await client.query(SQL_SCHEMA);
  console.log("Tables (re)created based on index.js schema.");

  // --- Start of new seeding from seed.sql ---
  try {
    const seedSqlContent = await fs.readFile("./seed.sql", "utf8");
    await client.query(seedSqlContent);
    console.log("Data inserted from seed.sql successfully!");
  } catch (error) {
    // Handle specific error for unique violation if seed.sql is run multiple times
    if (error.code === "23505") {
      console.warn(
        "Seed data already exists (unique constraint violation). Skipping duplicate inserts from seed.sql."
      );
    } else {
      console.error("Error executing seed.sql:", error);
      throw error; // Re-throw to indicate a critical seeding failure
    }
  }
  // --- End of new seeding from seed.sql ---

  const [Justin, Chelsea, Callen, Ellie] = await Promise.all([
    createUser({
      id: uuidv4(),
      username: "Justin",
      password: "0710",
      is_admin: true,
    }),
    createUser({
      id: uuidv4(),
      username: "Chelsea",
      password: "1234",
      is_admin: true,
    }),
    createUser({
      id: uuidv4(),
      username: "Callen",
      password: "5678",
      is_admin: true,
    }),
    createUser({
      id: uuidv4(),
      username: "Ellie",
      password: "9012",
      is_admin: true,
    }),
  ]);

  // const [Cottage, Modern, Wild] = await Promise.all([
  //   createDesign({
  //     id: uuidv4(),
  //     design_style_name: "Cottage",
  //     design_attributes: "Summer",
  //   }),
  //   createDesign({
  //     id: uuidv4(),
  //     design_style_name: "Modern",
  //     design_attributes: "Spring",
  //   }),
  //   createDesign({
  //     id: uuidv4(),
  //     design_style_name: "Wild",
  //     design_attributes: "Fall",
  //   }),
  // ]);

  // const [Boxwood, SJPYew, JPFern] = await Promise.all([
  //   createPlant({
  //     plant_name: "boxwood",
  //     other_common_names: null,
  //     technical_name: "buxus spp.",
  //     growth_form: "shrub",
  //     is_toxic: false,
  //     sun_requirements: "full-sun, part-shade",
  //     height_min_ft: 2.0,
  //     height_max_ft: 15.0,
  //     width_min_ft: 2.0,
  //     width_max_ft: 4.0,
  //     seasonal_interest: null,
  //     primary_color: "grass_green",
  //     accent_color: null,
  //     image_url:
  //       "https://res.cloudinary.com/dprixcop0/image/upload/v1753128204/boxwood_gqpns0.webp",
  //   }),
  //   createPlant({
  //     plant_name: "spreading japanese plum yew",
  //     other_common_names: null,
  //     technical_name: "taxus baccata",
  //     growth_form: "large shrub, small tree",
  //     is_toxic: true,
  //     sun_requirements: "part-shade, full-shade",
  //     height_min_ft: 3.0,
  //     height_max_ft: 10.0,
  //     width_min_ft: 3.0,
  //     width_max_ft: 10.0,
  //     seasonal_interest: null,
  //     primary_color: "lime_green",
  //     accent_color: "plum",
  //     image_url:
  //       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282058/spreading-japanese-plum-yew_elpkcr.webp",
  //   }),
  //   createPlant({
  //     plant_name: "japanese painted fern",
  //     other_common_names: null,
  //     technical_name: "athyrium niponicum var. pictum",
  //     growth_form: "herbaceous",
  //     is_toxic: true,
  //     sun_requirements: "part-shade, full-shade",
  //     height_min_ft: 1.0,
  //     height_max_ft: 1.5,
  //     width_min_ft: 1.0,
  //     width_max_ft: 1.5,
  //     seasonal_interest: "spring,summer",
  //     primary_color: "purple_brown",
  //     accent_color: "pale_green",
  //     image_url:
  //       "https://res.cloudinary.com/dprixcop0/image/upload/v1753127972/japanese-painted-fern_tioauz.jpg",
  //   }),
  // ]);

  await Promise.all([
    createFavoritePlant({
      id: uuidv4(),
      user_id: Justin.id,
      plant_id: JPFern.id,
    }),
    createFavoritePlant({
      id: uuidv4(),
      user_id: Ellie.id,
      plant_id: SJPYew.id,
    }),
    createFavoritePlant({
      id: uuidv4(),
      user_id: Callen.id,
      plant_id: Boxwood.id,
    }),
    createFavoritePlant({
      id: uuidv4(),
      user_id: Chelsea.id,
      plant_id: SJPYew.id,
    }),
  ]);

  const [BackyardForest] = await Promise.all([
    createProject({
      id: uuidv4(),
      project_name: "BackyardForest",
      user_id: Justin.id,
    }),
  ]);

  const [newBeginnigs, FernForest, AbsoluteSucculent] = await Promise.all([
    createLayout({
      id: uuidv4(),
      layout_name: "newBeginnigs",
      bedding_size: 100,
      design_type: Cottage.id,
      projects_id: BackyardForest.id,
    }),
    createLayout({
      id: uuidv4(),
      layout_name: "FernForest",
      bedding_size: 450,
      design_type: Modern.id,
      projects_id: BackyardForest.id,
    }),
    createLayout({
      id: uuidv4(),
      layout_name: "AbsoluteSucculent",
      bedding_size: 210,
      design_type: Wild.id,
      projects_id: BackyardForest.id,
    }),
  ]);

  await Promise.all([
    createPlantDesign({
      id: uuidv4(),
      plant_id: Boxwood.id,
      design_id: Wild.id,
    }),
    createPlantDesign({
      id: uuidv4(),
      plant_id: SJPYew.id,
      design_id: Cottage.id,
    }),
    createPlantDesign({
      id: uuidv4(),
      plant_id: Boxwood.id,
      design_id: Cottage.id,
    }),
  ]);

  await Promise.all([
    createPlantLayout({
      id: uuidv4(),
      plant_id: JPFern.id,
      layout_id: newBeginnigs.id,
      placement: 78,
    }),
    createPlantLayout({
      id: uuidv4(),
      plant_id: SJPYew.id,
      layout_id: FernForest.id,
      placement: 567,
    }),
    createPlantLayout({
      id: uuidv4(),
      plant_id: Boxwood.id,
      layout_id: AbsoluteSucculent.id,
      placement: 123,
    }),
  ]);

  await Promise.all([
    createFaveDesign({ id: uuidv4(), user_id: Ellie.id, design_id: Modern.id }),
    createFaveDesign({ id: uuidv4(), user_id: Callen.id, design_id: Wild.id }),
    createFaveDesign({
      id: uuidv4(),
      user_id: Chelsea.id,
      design_id: Cottage.id,
    }),
  ]);

  console.log("Tables Seeded");
};

module.exports = {
  client,
  seed,
};
