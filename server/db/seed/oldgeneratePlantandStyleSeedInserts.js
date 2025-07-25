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
const PLANTS_CSV_PATH = "./csv/250724 plantscape export - Plants.csv";
const STYLES_CSV_PATH = "./csv/250724 plantscape export - Styles.csv";

// From DesignStyleContext.jsx (still hardcoded for now, as it's from a JS file)
const defaultStylesFromContext = [
  { id: 1, name: "Classical", gridMinCols: 4, spacingFactor: 1.2 },
  { id: 2, name: "Modern", gridMinCols: 3, spacingFactor: 1.4 },
  { id: 3, name: "Cottage", gridMinCols: 3, spacingFactor: 1.3 },
  { id: 4, name: "Naturalistic", gridMinCols: 2, spacingFactor: 1.1 },
];

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
  // Start with an empty string for SQL statements, as CREATE TABLE is handled by index.js
  let sqlStatements = `-- SQL INSERT statements generated on ${new Date().toISOString()}\n\n`;

  // Read both CSV data files dynamically
  const plantsCsvContent = await readCsvFile(PLANTS_CSV_PATH);
  const stylesCsvContent = await readCsvFile(STYLES_CSV_PATH);

  const plantsData = parseCsv(plantsCsvContent);
  const stylesData = parseCsv(stylesCsvContent);

  const designStylesMap = new Map(); // Maps design style name to its ID
  let designInserts = [];
  let plantInserts = [];
  let plantDesignTypesInserts = [];

  // 1. Populate designs table from Styles.csv and DesignStyleContext.jsx
  const allDesignNames = new Set();

  // Process styles from Styles.csv first
  stylesData.forEach((style) => {
    const name = style.style.trim().toLowerCase(); // Convert to lowercase
    if (name && !allDesignNames.has(name)) {
      allDesignNames.add(name);
      const id = uuidv4();
      designStylesMap.set(name, id);
      // Truncate description and convert to lowercase
      const designAttributes = (style.description || "")
        .substring(0, 50)
        .toLowerCase();
      designInserts.push({
        id,
        design_style_name: name,
        design_attributes: designAttributes || null,
      });
    }
  });

  // Add/Update styles from DesignStyleContext.jsx if not already present from CSV
  defaultStylesFromContext.forEach((contextStyle) => {
    const name = contextStyle.name.trim().toLowerCase(); // Convert to lowercase
    if (name && !allDesignNames.has(name)) {
      allDesignNames.add(name);
      const id = uuidv4();
      designStylesMap.set(name, id);
      designInserts.push({
        id,
        design_style_name: name,
        design_attributes: null,
      });
    }
  });

  sqlStatements += `-- Designs Inserts\n`;
  designInserts.forEach((design) => {
    sqlStatements += `INSERT INTO designs (id, design_style_name, design_attributes) VALUES (\n`;
    sqlStatements += `  '${design.id}',\n`;
    sqlStatements += `  '${design.design_style_name.replace(/'/g, "''")}',\n`;
    sqlStatements += `  ${
      design.design_attributes
        ? `'${design.design_attributes.replace(/'/g, "''")}'`
        : "NULL"
    }\n`;
    sqlStatements += `) ON CONFLICT (id) DO NOTHING;\n\n`;
  });

  // 2. Populate plants table with expanded schema
  sqlStatements += `-- Plants Inserts\n`;
  plantsData.forEach((plant) => {
    const plantId = uuidv4();
    // Convert string fields to lowercase where applicable
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

    // 3. Populate plant_Design_Types table
    const adaptableStyles = plant["Adaptable Styles"]
      .split(",")
      .map((s) => s.trim().toLowerCase())
      .filter(Boolean);
    adaptableStyles.forEach((styleName) => {
      const designId = designStylesMap.get(styleName); // Lookup using lowercase name
      if (designId) {
        plantDesignTypesInserts.push({
          plant_id: plantId,
          design_id: designId,
        });
        sqlStatements += `INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('${uuidv4()}', '${plantId}', '${designId}') ON CONFLICT (plant_id, design_id) DO NOTHING;\n`;
      } else {
        console.warn(
          `Warning: Design style "${styleName}" not found for plant "${plant.Name}" in designs table.`
        );
      }
    });
    sqlStatements += `\n`;
  });

  fs.writeFileSync("seed.sql", sqlStatements);
  console.log('SQL SEED file "seed.sql" generated successfully!');
}

// Call the main function to generate the seed file
generateSeedFile();
