import fs from "fs";
import { parse } from "csv-parse/sync";

// Read CSV file (ensure plants.csv is in same folder as this script)
const csvInput = fs.readFileSync("./plants.csv", "utf-8");

// Parse CSV with trimmed headers and values
const records = parse(csvInput, {
  columns: (header) => header.map((h) => h.trim()),
  skip_empty_lines: true,
  trim: true,
});

let plantId = 1;
const plantsInserts = [];
const lightsInserts = [];
const stylesInserts = [];

for (const r of records) {
  const name = (r["Common Name(s)"] || "").replace(/'/g, "''");
  const technicalName = (r["Technical Name"] || "").replace(/'/g, "''");

  const diameterMin = parseFloat(r["Width Min"]) || 0;
  const diameterMax = parseFloat(r["Width Max"]) || 0;

  const heightMin = parseFloat(r["Height Min (ft)"]) || 0;
  const heightMax = parseFloat(r["Height Max (ft)"]) || 0;

  const light = (r["Sun Reqs"] || "")
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);

  const style = (r["Adaptable Styles"] || "")
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);

  plantsInserts.push(
    `INSERT INTO plants (id, name, technical_name, diameter_min_ft, diameter_max_ft, height_min_ft, height_max_ft)\n` +
      `VALUES (${plantId}, '${name}', '${technicalName}', ${diameterMin}, ${diameterMax}, ${heightMin}, ${heightMax});`
  );

  light.forEach((l) => {
    lightsInserts.push(
      `INSERT INTO plant_lights (plant_id, light) VALUES (${plantId}, '${l.replace(
        /'/g,
        "''"
      )}');`
    );
  });

  style.forEach((s) => {
    stylesInserts.push(
      `INSERT INTO plant_styles (plant_id, style) VALUES (${plantId}, '${s.replace(
        /'/g,
        "''"
      )}');`
    );
  });

  plantId++;
}

const sqlOutput = [
  "-- Inserts for plants",
  ...plantsInserts,
  "\n-- Inserts for plant_lights",
  ...lightsInserts,
  "\n-- Inserts for plant_styles",
  ...stylesInserts,
].join("\n\n");

fs.writeFileSync("plants_seed.sql", sqlOutput);

console.log("plants_seed.sql generated!");
