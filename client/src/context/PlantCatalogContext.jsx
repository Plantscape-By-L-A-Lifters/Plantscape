// context/PlantCatalogContext.jsx
import { createContext, useState, useEffect, useCallback } from "react";
import axios from "axios";

export const PlantCatalogContext = createContext();

export const PlantCatalogProvider = ({ children }) => {
  const [plantCatalog, setPlantCatalog] = useState([]);
  const [loadingPlants, setLoadingPlants] = useState(true);

  const fetchPlants = useCallback(async () => {
    setLoadingPlants(true); // Set loading to true before fetching
    try {
      // Corrected API path with leading slash
      const { data } = await axios.get("/api/plants");
      setPlantCatalog(data);
      console.log("Fetched plants data:", data);
    } catch (err) {
      console.error("Failed to fetch plants:", err);
      setPlantCatalog([]); // Clear catalog on error
    } finally {
      setLoadingPlants(false); // Set loading to false after fetch completes (success or error)
    }
  }, []); // Dependencies for fetchPlants useCallback: Empty array as it doesn't depend on external state

  //
  useEffect(() => {
    fetchPlants();
  }, [fetchPlants]);

  return (
    <PlantCatalogContext.Provider
      value={{ plantCatalog, setPlantCatalog, loadingPlants }}
    >
      {children}
    </PlantCatalogContext.Provider>
  );
};
