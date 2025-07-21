// context/PlantCatalogContext.jsx
import { createContext, useState, useEffect } from "react";
import axios from "axios";

export const PlantCatalogContext = createContext();

export const PlantCatalogProvider = ({ children }) => {
  const [plantCatalog, setplantCatalog] = useState([]);

  useEffect(() => {
    const fetchPlants = async () => {
      try {
        const { data } = await axios.get("api/plants");
        console.log("plants data", data);
        setplantCatalog(data);
      } catch (err) {
        console.error("Failed to fetch plants", err);
      }
    };
    fetchPlants();
  }, []);

  return (
    <PlantCatalogContext.Provider value={{ plantCatalog, setplantCatalog }}>
      {children}
    </PlantCatalogContext.Provider>
  );
};
