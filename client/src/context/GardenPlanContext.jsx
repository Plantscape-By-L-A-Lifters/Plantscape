// src/context/GardenPlanContext.jsx
import { createContext, useContext, useState } from "react";

export const GardenPlanContext = createContext(null);
GardenPlanContext.displayName = "GardenPlanContext";

export const GardenPlanProvider = ({ children }) => {
  // const [currentProject, setCurrentProject] = useState(
  //   {id: 1,
  //   name: "My Backyard",
  //   description: "",
  //   created_at,
  //   user_id}
  // );
  // const [ projectBeds, setProjectBeds] = useState([]);
  // const [ selectedBed, setSelectedBed] = useState(null);
  // const [{id, name, bedLength, bedDepth, project_id]
  const [bedSize, setBedSize] = useState({ bedLength: 12, bedDepth: 6 });

  const [placedPlants, setPlacedPlants] = useState([
    {
      id: 1,
      plant_id: 25,
      name: "Japanese Painted Fern",
      technical_name: "Athyrium niponicum var. pictum",
      diameter_min_ft: 1,
      diameter_max_ft: 1.5,
      height_min_ft: 1,
      height_max_ft: 1.5,
      color: "purple-brown",
      accent_color: "pale_green",
    },
    {
      id: 2,
      plant_id: 29,
      name: "Foamflower",
      technical_name: "Tiarella cordifolia",
      diameter_min_ft: 1,
      diameter_max_ft: 2,
      height_min_ft: 0.5,
      height_max_ft: 1,
      image: "../../public/foamflower.jpg",
      icon: "/icons/foamflower.jpg",
      shape: "circle",
      accent_color: "white",
      color: "lime_green",
    },
  ]); // includes x/y positions

  // TODO: future states:
  // const [style, setStyle] = useState(null);
  // const [sunlight, setSunlight] = useState("full_sun");
  // const [plantRecommendations, setPlantRecommendations] = useState([]);

  return (
    <GardenPlanContext.Provider
      value={{
        bedSize,
        setBedSize,
        placedPlants,
        setPlacedPlants,
      }}
    >
      {children}
    </GardenPlanContext.Provider>
  );
};

// info would be setup like this:
// // {
//placedPlants State:
// id: 1,
// plant_id: UUID
// bed_id: UUID
// x: 5, //bedSize.length/2-radius
// y: 1, //tallest plant goes in back, so, just diameter/2

// plants find by plant_id the following:
// name: plant.name
// diameter: plant.diameter_min_ft //for now... later we can optimize for range of sizes
// height: plant.height_min_ft //for now... later we can optimize for range of sizes
// color: "sage_green",
// accent_color: "goldenrod",

// colors.js find by name the following:
// color: color.hexCode;
// accent_color: color.hexcode
// },
