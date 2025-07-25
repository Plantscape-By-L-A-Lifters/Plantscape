// generatePlantDataSeed.js
const fs = require("fs"); // For synchronous writeFileSync
const fsPromises = require("fs").promises; // For promise-based readFile
const { v4: uuidv4 } = require("uuid");

// Helper function to read a CSV file
async function readCsvFile(filePath) {
  try {
    const data = await fsPromises.readFile(filePath, "utf8");
    console.log(`Successfully read file: ${filePath}`);
    return data;
  } catch (error) {
    console.error(`Error reading CSV file at ${filePath}:`, error);
    throw new Error(`Failed to read CSV file: ${filePath}`);
  }
}

// --- CSV File Paths ---
const PLANTS_CSV_PATH = "./csv/plantscape - Plants.csv";
const STYLES_CSV_PATH = "./csv/plantscape - Styles.csv";

// defaultStylesFromContext has been completely removed as requested.

// --- Functions for CSV parsing ---

function parseCsv(csvString) {
  const lines = csvString.trim().split("\n");
  const headers = lines[0].split(",").map((header) => header.trim());
  const data = [];

  for (let i = 1; i < lines.length; i++) {
    const values = parseCsvLine(lines[i]);
    if (values.length === headers.length) {
      let row = {};
      for (let j = 0; j < headers.length; j++) {
        row[headers[j]] = values[j];
      }
      data.push(row);
    }
  }
  return data;
}

// Improved CSV line parsing to handle commas within quoted fields
function parseCsvLine(line) {
  const result = [];
  let inQuote = false;
  let currentField = "";
  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      inQuote = !inQuote;
      if (inQuote && line[i + 1] === '"') {
        // Handle escaped double quote
        currentField += '"';
        i++;
      }
    } else if (char === "," && !inQuote) {
      result.push(currentField.trim());
      currentField = "";
    } else {
      currentField += char;
    }
  }
  result.push(currentField.trim());
  return result;
}

// --- Main Seed Generation Function ---

async function generateSeedFile() {
  let sqlStatements = `-- SQL SEED File generated on ${new Date().toISOString()}\n\n`;

  // --- 1. Drop Tables (from index.js) ---
  sqlStatements += `
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS plant_layout;
DROP TABLE IF EXISTS layouts;
DROP TABLE IF EXISTS favorite_plants;
DROP TABLE IF EXISTS plant_Design_Types;
DROP TABLE IF EXISTS fave_design;
DROP TABLE IF EXISTS plants;
DROP TABLE IF EXISTS designs;
DROP TABLE IF EXISTS users;

`;

  // --- 2. Create Tables (with NEW designs table schema) ---
  sqlStatements += `
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users(
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    is_admin BOOLEAN DEFAULT false NOT NULL
);

CREATE TABLE designs(
    id UUID PRIMARY KEY,
    design_style_name VARCHAR(50) UNIQUE NOT NULL,
    design_attributes VARCHAR(255), -- Now for short description
    design_description TEXT,        -- New: for long description
    design_tags TEXT                -- New: for tags
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
    design_id UUID REFERENCES designs(id),
    UNIQUE (plant_id, design_id) -- Added unique constraint
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

  // --- 3. Read CSV Data ---
  const plantsCsvContent = await readCsvFile(PLANTS_CSV_PATH);
  const stylesCsvContent = await readCsvFile(STYLES_CSV_PATH);

  const plantsData = parseCsv(plantsCsvContent);
  const stylesData = parseCsv(stylesCsvContent);

  // Maps to store generated UUIDs for relationships
  const designStylesMap = new Map(); // Maps design style name to its ID
  const plantMap = new Map(); // Maps plant name to its ID
  const userMap = new Map(); // Maps username to its ID
  const projectMap = new Map(); // Maps project name to its ID
  const layoutMap = new Map(); // Maps layout name to its ID

  // --- 4. INSERT Statements ---

  // Users (from index.js)
  sqlStatements += `\n-- Users Inserts\n`;
  const users = [
    { username: "Justin", password: "0710", is_admin: true },
    { username: "Chelsea", password: "1234", is_admin: true },
    { username: "Callen", password: "5678", is_admin: true },
    { username: "Ellie", password: "9012", is_admin: true },
  ];
  for (const user of users) {
    const id = uuidv4();
    userMap.set(user.username.toLowerCase(), id); // Store lowercase username -> ID
    sqlStatements += `INSERT INTO users (id, username, password, is_admin) VALUES ('${id}', '${
      user.username
    }', '${user.password}', ${
      user.is_admin ? "TRUE" : "FALSE"
    }) ON CONFLICT (id) DO NOTHING;\n`;
  }
  sqlStatements += `\n`;

  // Designs (ONLY from Styles.csv)
  sqlStatements += `-- Designs Inserts\n`;
  const allDesignNames = new Set();
  const tempDesignInserts = []; // Collect unique designs first

  // Process styles from Styles.csv (new columns: name, short description, long description, tags)
  stylesData.forEach((style) => {
    const name = style.name.trim().toLowerCase(); // Use 'name' column
    if (name && !allDesignNames.has(name)) {
      allDesignNames.add(name);
      const id = uuidv4();
      designStylesMap.set(name, id);
      // Map to new schema
      const shortDescription = (style["short description"] || "")
        .substring(0, 255)
        .replace(/'/g, "''"); // Max 255 chars for VARCHAR
      const longDescription = (style["long description"] || "").replace(
        /'/g,
        "''"
      ); // TEXT type, so no length limit
      const tags = (style["tags"] || "").toLowerCase().replace(/'/g, "''"); // Lowercase tags

      tempDesignInserts.push({
        id,
        design_style_name: name,
        design_attributes: shortDescription || null, // short description
        design_description: longDescription || null, // long description
        design_tags: tags || null, // tags
      });
    }
  });

  // Write all collected unique design inserts
  tempDesignInserts.forEach((design) => {
    sqlStatements += `INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (\n`;
    sqlStatements += `  '${design.id}',\n`;
    sqlStatements += `  '${design.design_style_name.replace(/'/g, "''")}',\n`;
    sqlStatements += `  ${
      design.design_attributes ? `'${design.design_attributes}'` : "NULL"
    },\n`;
    sqlStatements += `  ${
      design.design_description ? `'${design.design_description}'` : "NULL"
    },\n`;
    sqlStatements += `  ${
      design.design_tags ? `'${design.design_tags}'` : "NULL"
    }\n`;
    sqlStatements += `) ON CONFLICT (id) DO NOTHING;\n\n`;
  });

  // Plants (from Plants.csv) - No changes needed here based on this request
  sqlStatements += `-- Plants Inserts\n`;
  plantsData.forEach((plant) => {
    const plantId = uuidv4();
    plantMap.set(plant.Name.toLowerCase(), plantId); // Store plant name -> ID
    const plantName = plant.Name.toLowerCase();
    const otherCommonNames = plant["Other Common Names"]
      ? plant["Other Common Names"].toLowerCase()
      : null;
    const technicalName = plant["Technical Name"]
      ? plant["Technical Name"].toLowerCase()
      : null;
    const growthForm = plant["growth form"]
      ? plant["growth form"].toLowerCase()
      : null;
    const isToxic = plant.toxic.toLowerCase() === "toxic" ? "TRUE" : "FALSE";
    const sunRequirements = plant["Sun Requirements"]
      ? plant["Sun Requirements"].toLowerCase()
      : null;
    const seasonalInterest = plant["Seasonal Interest"]
      ? plant["Seasonal Interest"].toLowerCase()
      : null;
    const primaryColor = plant["primary color"]
      ? plant["primary color"].toLowerCase()
      : null;
    const accentColor = plant["accent color"]
      ? plant["accent color"].toLowerCase()
      : null;
    const imageUrl = plant["IMAGE URL"]
      ? plant["IMAGE URL"].toLowerCase()
      : null;

    const heightMin = parseFloat(plant["Height Min (ft)"]) || null;
    const heightMax = parseFloat(plant["Height Max (ft)"]) || null;
    const widthMin = parseFloat(plant["Width Min (ft)"]) || null;
    const widthMax = parseFloat(plant["Width Max (ft)"]) || null;

    sqlStatements += `INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (\n`;
    sqlStatements += `  '${plantId}',\n`;
    sqlStatements += `  '${plantName.replace(/'/g, "''")}',\n`;
    sqlStatements += `  ${
      otherCommonNames ? `'${otherCommonNames.replace(/'/g, "''")}'` : "NULL"
    },\n`;
    sqlStatements += `  ${
      technicalName ? `'${technicalName.replace(/'/g, "''")}'` : "NULL"
    },\n`;
    sqlStatements += `  ${
      growthForm ? `'${growthForm.replace(/'/g, "''")}'` : "NULL"
    },\n`;
    sqlStatements += `  ${isToxic},\n`;
    sqlStatements += `  ${
      sunRequirements ? `'${sunRequirements.replace(/'/g, "''")}'` : "NULL"
    },\n`;
    sqlStatements += `  ${heightMin !== null ? heightMin : "NULL"},\n`;
    sqlStatements += `  ${heightMax !== null ? heightMax : "NULL"},\n`;
    sqlStatements += `  ${widthMin !== null ? widthMin : "NULL"},\n`;
    sqlStatements += `  ${widthMax !== null ? widthMax : "NULL"},\n`;
    sqlStatements += `  ${
      seasonalInterest ? `'${seasonalInterest.replace(/'/g, "''")}'` : "NULL"
    },\n`;
    sqlStatements += `  ${
      primaryColor ? `'${primaryColor.replace(/'/g, "''")}'` : "NULL"
    },\n`;
    sqlStatements += `  ${
      accentColor ? `'${accentColor.replace(/'/g, "''")}'` : "NULL"
    },\n`;
    sqlStatements += `  ${
      imageUrl ? `'${imageUrl.replace(/'/g, "''")}'` : "NULL"
    }\n`;
    sqlStatements += `) ON CONFLICT (id) DO NOTHING;\n\n`;
  });

  // plant_Design_Types (from Plants.csv's "Adaptable Styles")
  sqlStatements += `-- plant_Design_Types Inserts\n`;
  plantsData.forEach((plant) => {
    const plantId = plantMap.get(plant.Name.toLowerCase()); // Get ID from map
    const adaptableStyles = plant["Adaptable Styles"]
      .split(",")
      .map((s) => s.trim().toLowerCase())
      .filter(Boolean);
    adaptableStyles.forEach((styleName) => {
      const designId = designStylesMap.get(styleName); // Get ID from map
      if (plantId && designId) {
        sqlStatements += `INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('${uuidv4()}', '${plantId}', '${designId}') ON CONFLICT (plant_id, design_id) DO NOTHING;\n`;
      } else {
        console.warn(
          `Warning: Could not create plant_Design_Types for plant "${plant.Name}" (ID: ${plantId}) and style "${styleName}" (ID: ${designId}).`
        );
      }
    });
    sqlStatements += `\n`;
  });

  // Projects (from index.js, adjust names if needed to match frontend)
  sqlStatements += `-- Projects Inserts\n`;
  const projects = [{ name: "BackyardForest", user: "Justin" }];
  for (const project of projects) {
    const projectId = uuidv4();
    projectMap.set(project.name.toLowerCase(), projectId); // Store project name -> ID
    const userId = userMap.get(project.user.toLowerCase());
    if (userId) {
      sqlStatements += `INSERT INTO projects (id, project_name, user_id) VALUES ('${projectId}', '${project.name}', '${userId}') ON CONFLICT (id) DO NOTHING;\n`;
    } else {
      console.warn(
        `Warning: User "${project.user}" not found for project "${project.name}".`
      );
    }
  }
  sqlStatements += `\n`;

  // Layouts (from index.js)
  sqlStatements += `-- Layouts Inserts\n`;
  const layouts = [
    {
      name: "newBeginnings",
      bedding_size: 10,
      design_style: "cottage",
      project: "BackyardForest",
    },
    {
      name: "FernForest",
      bedding_size: 450,
      design_style: "modern",
      project: "BackyardForest",
    },
    {
      name: "AbsoluteSucculent",
      bedding_size: 210,
      design_style: "naturalistic",
      project: "BackyardForest",
    },
  ];
  for (const layout of layouts) {
    const layoutId = uuidv4();
    layoutMap.set(layout.name.toLowerCase(), layoutId); // Store layout name -> ID
    const designId = designStylesMap.get(layout.design_style.toLowerCase());
    const projectId = projectMap.get(layout.project.toLowerCase());
    if (designId && projectId) {
      sqlStatements += `INSERT INTO layouts (id, layout_name, bedding_size, design_type, projects_id) VALUES (\n`;
      sqlStatements += `  '${layoutId}',\n`;
      sqlStatements += `  '${layout.name}',\n`;
      sqlStatements += `  ${layout.bedding_size},\n`;
      sqlStatements += `  '${designId}',\n`;
      sqlStatements += `  '${projectId}'\n`;
      sqlStatements += `) ON CONFLICT (id) DO NOTHING;\n\n`;
    } else {
      console.warn(
        `Warning: Could not create layout "${layout.name}" due to missing design (${layout.design_style}) or project (${layout.project}).`
      );
    }
  }
  sqlStatements += `\n`;

  // Favorite Plants (from index.js)
  sqlStatements += `-- Favorite Plants Inserts\n`;
  const favoritePlants = [
    { user: "Justin", plant: "japanese painted fern" },
    { user: "Ellie", plant: "spreading japanese plum yew" },
    { user: "Callen", plant: "boxwood" },
    { user: "Chelsea", plant: "spreading japanese plum yew" },
  ];
  for (const fav of favoritePlants) {
    const userId = userMap.get(fav.user.toLowerCase());
    const plantId = plantMap.get(fav.plant.toLowerCase());
    if (userId && plantId) {
      sqlStatements += `INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('${uuidv4()}', '${userId}', '${plantId}') ON CONFLICT (user_id, plant_id) DO NOTHING;\n`;
    } else {
      console.warn(
        `Warning: Could not create favorite plant for user "${fav.user}" and plant "${fav.plant}".`
      );
    }
  }
  sqlStatements += `\n`;

  // Plant Layout (from index.js)
  sqlStatements += `-- Plant Layout Inserts\n`;
  const plantLayouts = [
    { plant: "japanese painted fern", layout: "newbeginnigs", placement: 78 },
    {
      plant: "spreading japanese plum yew",
      layout: "fernforest",
      placement: 567,
    },
    { plant: "boxwood", layout: "absolutesucculent", placement: 123 },
  ];
  for (const pl of plantLayouts) {
    const plantId = plantMap.get(pl.plant.toLowerCase());
    const layoutId = layoutMap.get(pl.layout.toLowerCase());
    if (plantId && layoutId) {
      sqlStatements += `INSERT INTO plant_layout (id, plant_id, layout_id, placement) VALUES ('${uuidv4()}', '${plantId}', '${layoutId}', ${
        pl.placement
      }) ON CONFLICT (id) DO NOTHING;\n`;
    } else {
      console.warn(
        `Warning: Could not create plant_layout for plant "${pl.plant}" and layout "${pl.layout}".`
      );
    }
  }
  sqlStatements += `\n`;

  // Fave Designs (from index.js)
  sqlStatements += `-- Fave Designs Inserts\n`;
  const faveDesigns = [
    { user: "Ellie", design_style: "modern" },
    { user: "Callen", design_style: "naturalistic" },
    { user: "Chelsea", design_style: "cottage" },
  ];
  for (const fd of faveDesigns) {
    const userId = userMap.get(fd.user.toLowerCase());
    const designId = designStylesMap.get(fd.design_style.toLowerCase());
    if (userId && designId) {
      sqlStatements += `INSERT INTO fave_design (id, user_id, design_id) VALUES ('${uuidv4()}', '${userId}', '${designId}') ON CONFLICT (id) DO NOTHING;\n`;
    } else {
      console.warn(
        `Warning: Could not create fave_design for user "${fd.user}" and design "${fd.design_style}".`
      );
    }
  }
  sqlStatements += `\n`;

  // Write the complete SQL SEED file
  fs.writeFileSync("seed.sql", sqlStatements);
  console.log('COMPLETE SQL SEED file "seed.sql" generated successfully!');
}

// Call the main function to generate the seed file
generateSeedFile();
