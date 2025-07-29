// context/PlantCatalogContext.jsx
import {
  createContext,
  useState,
  useEffect,
  useCallback,
  useContext,
} from "react";
import { UserContext } from "./UserContext";
import axios from "axios";

export const PlantCatalogContext = createContext();

export const PlantCatalogProvider = ({ children }) => {
  const [plantCatalog, setPlantCatalog] = useState([]);
  const [plant, setPlant] = useState(null);
  const [loadingPlants, setLoadingPlants] = useState(false);
  const [loadingSinglePlant, setLoadingSinglePlant] = useState(false);
  const [errorPlantCatalog, setErrorPlantCatalog] = useState(null);
  const [errorSinglePlant, setErrorSinglePlant] = useState(null);
  const { user, getHeaders } = useContext(UserContext);
  const [favoritePlant, setFavoritePlant] = useState([]);

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
     // 
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

  //  Helper function to find a plant by its name from the already loaded catalog
  // Now returns the full plant object if found, otherwise null.
  const plantByName = useCallback(
    (name) => {
      if (!name || plantCatalog.length === 0) {
        return null; // Return null if name is empty or catalog is not loaded
      }
      // Perform a case-insensitive search for the plant name
      const foundPlant = plantCatalog.find(
        (p) => p.plant_name.toLowerCase() === name.toLowerCase()
      );
      // Return the full plant object if found, otherwise null
      console.log(`plantByName: Searching for "${name}", found:`, foundPlant);
      return foundPlant;
    },
    [plantCatalog]
  ); // Dependency: plantCatalog, so it re-memoizes if the catalog changes

  // adds the capability to add favorites
const addFavePlant = useCallback(async (plantId) => {
  try {
    const { data } = await axios.post('/api/favorite_plants', { plant_id: plantId, user_id: user.id }, getHeaders());
    setFavoritePlant([...favoritePlant, data]); // Use functional update
  } catch (error) {
    console.error("Failed to add favorite plant:", error); // Consistent error logging
  }
}, [user, getHeaders]); // Dependencies for useCallback

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
        plantByName,
        addFavePlant,
        favoritePlant,
        setFavoritePlant
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
