// context/PlantLibraryContext.jsx
import { createContext, useState, useEffect } from "react";
import axios from "axios";

export const PlantLibraryContext = createContext();

export const PlantLibraryProvider = ({ children }) => {
  const [plantCatalog, setPlantCatalog] = useState([]);

  useEffect(() => {
    // Ideally fetch from API
    async function fetchPlants() {
      const response = await axios.get("/api/plants");
      setPlantCatalog(response.data);
    }

    fetchPlants();
  }, []);

  return (
    <PlantLibraryContext.Provider value={{ plantCatalog, setPlantCatalog }}>
      {children}
    </PlantLibraryContext.Provider>
  );
};
