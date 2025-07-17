// src/context/GardenPlanContext.jsx
import { createContext, useState } from "react";

export const GardenPlanContext = createContext(null);
GardenPlanContext.displayName = "GardenPlanContext";

export const GardenPlanProvider = ({ children }) => {
  const [bedSize, setBedSize] = useState({ width: 4, length: 8 });
  const [placedPlants, setPlacedPlants] = useState([
    { name: "Winecup", x: 1, y: 1, spacing: 12, color: "pink" },
    { name: "Coneflower", x: 3, y: 2, spacing: 18, color: "purple" },
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
