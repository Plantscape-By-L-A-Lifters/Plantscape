// api/layouts.js
const express = require("express");
const app = express.Router();
const {
  createLayout,
  fetchLayouts,
  fetchLayoutsById,
  createPlantLayout, // Ensure this is imported
  fetchPlantLayout, // Ensure this is imported
  fetchPlantLayoutById, // Ensure this is imported
} = require("../db/layouts"); // Assuming all layout and plant_layout functions are now in db/layouts.js
const { isLoggedIn } = require("./middleware");

// Route to create a new layout for a project
app.post("/:projectId/layouts", isLoggedIn, async (req, res, next) => {
  try {
    const { projectId } = req.params;
    const { layout_name, bed_length, bed_depth, design_type } = req.body;

    const layout = await createLayout({
      layout_name,
      bed_length,
      bed_depth,
      design_type,
      projects_id: projectId, // Associate with the project
    });
    res.status(201).send(layout);
  } catch (error) {
    next(error);
  }
});

// Route to fetch all layouts for a specific project
app.get("/:projectId/layouts", isLoggedIn, async (req, res, next) => {
  try {
    const layouts = await fetchLayouts(req.params.projectId);
    res.send(layouts);
  } catch (error) {
    next(error);
  }
});

// Route to fetch a single layout by its ID
app.get("/layouts/:id", isLoggedIn, async (req, res, next) => {
  try {
    const layout = await fetchLayoutsById(req.params.id);
    if (!layout) {
      return res.status(404).send({ message: "Layout not found." });
    }
    res.send(layout);
  } catch (error) {
    next(error);
  }
});

// Route to add a plant to a specific layout (UPDATED with error handling)
app.post("/layouts/:layoutId/plants", isLoggedIn, async (req, res, next) => {
  try {
    const { layoutId } = req.params;
    const { plant_id, x, y, diameter, height } = req.body;

    const newPlacedPlant = await createPlantLayout({
      plant_id,
      layout_id: layoutId,
      x_coord: x,
      y_coord: y,
      diameter,
      height,
    });
    res.status(201).send(newPlacedPlant);
  } catch (error) {
    // This 'catch' block will now handle errors thrown by createPlantLayout
    // If an error has a .status property (e.g., from validation), use it; otherwise, default to 500.
    res
      .status(error.status || 500)
      .send({
        message: error.message || "An error occurred while placing the plant.",
      });
    // Optionally, you can also call next(error) if you have a global error handler middleware
    // that logs errors or performs other actions.
    // next(error);
  }
});

// Route to fetch all plant_layout entries (NEW - moved from old api/plant_layout.js)
app.get("/plant_layout", isLoggedIn, async (req, res, next) => {
  try {
    const plantLayouts = await fetchPlantLayout();
    res.send(plantLayouts);
  } catch (error) {
    next(error);
  }
});

// Route to fetch a single plant_layout entry by its ID (NEW - moved from old api/plant_layout.js)
app.get("/plant_layout/:id", isLoggedIn, async (req, res, next) => {
  try {
    const plantLayout = await fetchPlantLayoutById(req.params.id);
    if (!plantLayout) {
      return res.status(404).send({ message: "Plant layout entry not found." });
    }
    res.send(plantLayout);
  } catch (error) {
    next(error);
  }
});

module.exports = app;
