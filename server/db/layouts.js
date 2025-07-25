// db/layouts.js
const client = require("./client");
const { v4 } = require("uuid");
const uuidv4 = v4;

// createLayout (existing function)
const createLayout = async (layout) => {
  const SQL = `
    INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING *
    `;
  const response = await client.query(SQL, [
    uuidv4(),
    layout.layout_name,
    layout.bed_length,
    layout.bed_depth,
    layout.design_type,
    layout.projects_id,
  ]);
  return response.rows[0];
};

// createPlantLayout (UPDATED - from old plant_layout.js, now using new schema fields)
const createPlantLayout = async ({
  plant_id,
  layout_id,
  x_coord,
  y_coord,
  diameter,
  height,
}) => {
  const SQL = `
   INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height)
   VALUES  ($1, $2, $3, $4, $5, $6, $7)
   RETURNING *
   `;
  const response = await client.query(SQL, [
    uuidv4(),
    plant_id,
    layout_id,
    x_coord,
    y_coord,
    diameter,
    height,
  ]);
  return response.rows[0];
};

// fetchLayouts (existing function)
const fetchLayouts = async (projectId) => {
  const SQL = `
    SELECT
        l.id AS layout_id,
        l.layout_name,
        l.bed_length,
        l.bed_depth,
        l.design_type,
        l.projects_id,
        pl.id AS plant_layout_id,
        pl.x_coord,
        pl.y_coord,
        pl.diameter,
        pl.height,
        p.id AS plant_id,
        p.plant_name,
        p.other_common_names,
        p.technical_name,
        p.growth_form,
        p.is_toxic,
        p.sun_requirements,
        p.height_min_ft,
        p.height_max_ft,
        p.width_min_ft,
        p.width_max_ft,
        p.seasonal_interest,
        p.primary_color,
        p.accent_color,
        p.image_url
    FROM layouts AS l
    LEFT JOIN plant_layout AS pl ON l.id = pl.layout_id
    LEFT JOIN plants AS p ON pl.plant_id = p.id
    WHERE l.projects_id = $1
    ORDER BY l.id, pl.id;
    `;
  const response = await client.query(SQL, [projectId]);

  const layoutsMap = new Map();
  response.rows.forEach((row) => {
    if (!layoutsMap.has(row.layout_id)) {
      layoutsMap.set(row.layout_id, {
        id: row.layout_id,
        layout_name: row.layout_name,
        bedSize: {
          bedLength: row.bed_length,
          bedDepth: row.bed_depth,
        },
        design_type: row.design_type,
        projects_id: row.projects_id,
        placedPlants: [],
      });
    }
    if (row.plant_layout_id) {
      layoutsMap.get(row.layout_id).placedPlants.push({
        id: row.plant_layout_id,
        x: row.x_coord,
        y: row.y_coord,
        diameter: row.diameter,
        height: row.height,
        plant_details: {
          id: row.plant_id,
          plant_name: row.plant_name,
          other_common_names: row.other_common_names,
          technical_name: row.technical_name,
          growth_form: row.growth_form,
          is_toxic: row.is_toxic,
          sun_requirements: row.sun_requirements,
          height_min_ft: row.height_min_ft,
          height_max_ft: row.height_max_ft,
          width_min_ft: row.width_min_ft,
          width_max_ft: row.width_max_ft,
          seasonal_interest: row.seasonal_interest,
          primary_color: row.primary_color,
          accent_color: row.accent_color,
          image_url: row.image_url,
        },
      });
    }
  });
  return Array.from(layoutsMap.values());
};

// fetchLayoutsById (existing function)
const fetchLayoutsById = async (id) => {
  const SQL = `
    SELECT
        l.id AS layout_id,
        l.layout_name,
        l.bed_length,
        l.bed_depth,
        l.design_type,
        l.projects_id,
        pl.id AS plant_layout_id,
        pl.x_coord,
        pl.y_coord,
        pl.diameter,
        pl.height,
        p.id AS plant_id,
        p.plant_name,
        p.other_common_names,
        p.technical_name,
        p.growth_form,
        p.is_toxic,
        p.sun_requirements,
        p.height_min_ft,
        p.height_max_ft,
        p.width_min_ft,
        p.width_max_ft,
        p.seasonal_interest,
        p.primary_color,
        p.accent_color,
        p.image_url
    FROM layouts AS l
    LEFT JOIN plant_layout AS pl ON l.id = pl.layout_id
    LEFT JOIN plants AS p ON pl.plant_id = p.id
    WHERE l.id = $1
    ORDER BY pl.id;
    `;
  const response = await client.query(SQL, [id]);

  if (response.rows.length === 0) {
    return null;
  }

  const firstRow = response.rows[0];
  const layout = {
    id: firstRow.layout_id,
    layout_name: firstRow.layout_name,
    bedSize: {
      bedLength: firstRow.bed_length,
      bedDepth: firstRow.bed_depth,
    },
    design_type: firstRow.design_type,
    projects_id: firstRow.projects_id,
    placedPlants: [],
  };

  if (firstRow.plant_layout_id) {
    response.rows.forEach((row) => {
      layout.placedPlants.push({
        id: row.plant_layout_id,
        x: row.x_coord,
        y: row.y_coord,
        diameter: row.diameter,
        height: row.height,
        plant_details: {
          id: row.plant_id,
          plant_name: row.plant_name,
          other_common_names: row.other_common_names,
          technical_name: row.technical_name,
          growth_form: row.growth_form,
          is_toxic: row.is_toxic,
          sun_requirements: row.sun_requirements,
          height_min_ft: row.height_min_ft,
          height_max_ft: row.height_max_ft,
          width_min_ft: row.width_min_ft,
          width_max_ft: row.width_max_ft,
          seasonal_interest: row.seasonal_interest,
          primary_color: row.primary_color,
          accent_color: row.accent_color,
          image_url: row.image_url,
        },
      });
    });
  }

  return layout;
};

// fetchPlantLayout (NEW - moved from plant_layout.js)
const fetchPlantLayout = async () => {
  const SQL = `
    SELECT id, plant_id, layout_id, x_coord, y_coord, diameter, height
    FROM plant_layout
    `;
  const response = await client.query(SQL);
  return response.rows;
};

// fetchPlantLayoutById (NEW - moved from plant_layout.js)
const fetchPlantLayoutById = async (id) => {
  const SQL = `
    SELECT id, plant_id, layout_id, x_coord, y_coord, diameter, height
    FROM plant_layout
    WHERE id = $1
    `;
  const response = await client.query(SQL, [id]);
  return response.rows[0];
};

module.exports = {
  createLayout,
  fetchLayouts,
  fetchLayoutsById,
  createPlantLayout, // Now handles x_coord, y_coord, diameter, height
  fetchPlantLayout, // New export
  fetchPlantLayoutById, // New export
};
