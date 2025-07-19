// src/context/GardenPlanContext.jsx
import { createContext, useContext, useState } from "react";

export const GardenPlanContext = createContext(null);
GardenPlanContext.displayName = "GardenPlanContext";

export const GardenPlanProvider = ({ children }) => {
  const [bedSize, setBedSize] = useState({ length: 10, depth: 4 });
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
