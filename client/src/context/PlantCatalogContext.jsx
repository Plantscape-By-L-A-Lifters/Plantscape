// context/PlantCatalogContext.jsx
import {
  createContext,
  useState,
  useEffect,
  useCallback,
  useContext,
} from "react";
import axios from "axios";

export const PlantCatalogContext = createContext();

export const PlantCatalogProvider = ({ children }) => {
  const [plantCatalog, setPlantCatalog] = useState([]);
  const [plant, setPlant] = useState(null);
  const [loadingPlants, setLoadingPlants] = useState(false);
  const [loadingSinglePlant, setLoadingSinglePlant] = useState(false);
  const [errorPlantCatalog, setErrorPlantCatalog] = useState(null);
  const [errorSinglePlant, setErrorSinglePlant] = useState(null);

  const fetchPlants = useCallback(async () => {
    console.log("ran fetch Plants function");
    setLoadingPlants(true); // Set loading to true before fetching
    try {
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

  const fetchPlantById = useCallback(async (plantId) => {
    console.log("ran fetch plant by ID");
    if (!plantId) {
      // Check for invalid ID first
      setErrorSinglePlant(
        new Error("Invalid plant ID: ID is undefined or null.")
      );
      setPlant(null);
      return null; // Exit early if ID is invalid
    }

    // ONLY if plantId is valid, then we proceed to set loading and make the API call
    setLoadingSinglePlant(true);
    setErrorSinglePlant(null); // Clear previous errors
    console.log("loading plant");
    try {
      const { data } = await axios.get(`/api/plants/${plantId}`);
      setPlant(data);
      console.log(data);
      return data;
    } catch (err) {
      console.error(`Failed to fetch plant by ID ${plantId}:`, err);
      setErrorSinglePlant(err);
      setPlant(null);
      throw err;
    } finally {
      setLoadingSinglePlant(false);
      console.log("no longer loading plant");
    }
  }, []);

  return (
    <PlantCatalogContext.Provider
      value={{
        plantCatalog,
        setPlantCatalog,
        loadingPlants,
        plant,
        setPlant,
        fetchPlantById,
        loadingSinglePlant,
        errorSinglePlant,
      }}
    >
      {children}
    </PlantCatalogContext.Provider>
  );
};

//custom hooks for convenience
export const usePlantCatalog = () => {
  const context = useContext(PlantCatalogContext);
  // This check ensures the hook is used within its Provider
  if (context === undefined) {
    throw new Error(
      "usePlantCatalog must be used within a PlantCatalogProvider"
    );
  }
  return context;
};
