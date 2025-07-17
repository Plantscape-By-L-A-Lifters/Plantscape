// src/context/GardenPlanContext.jsx
import { createContext, useContext, useState } from "react";

export const GardenPlanContext = createContext(null);
GardenPlanContext.displayName = "GardenPlanContext";

export const GardenPlanProvider = ({ children }) => {
  const [bedSize, setBedSize] = useState({ length: 10, depth: 4 });
  const [placedPlants, setPlacedPlants] = useState([
    { name: "Winecup", x: 1, y: 1, diameter: 1, color: "pink" },
    { name: "Coneflower", x: 3, y: 2, diameter: 1.5, color: "purple" },
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
