import { useContext, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import { UserContext } from "../context/UserContext";
import { GardenBedContext } from "../context/GardenBedContext";
import { DesignStyleContext } from "../context/DesignStyleContext";
import GardenCanvas from "../components/canvas/GardenCanvas";

const MyGardenBed = () => {
  const { user } = useContext(UserContext);
  const {
    currentEditingGardenBed, // The detailed garden bed object fetched by fetchSingleGardenBed
    fetchSingleGardenBed, // Function to fetch a single garden bed by ID
    loadingGardenBeds, // Loading state for garden beds
    addPlantToGardenBed, // for adding plants directly
  } = useContext(GardenBedContext);

  const { styles } = useContext(DesignStyleContext);
  const { layoutId } = useParams();

  // Effect to fetch the specific garden bed when the component mounts or layoutId changes
  useEffect(() => {
    if (layoutId && user?.id) {
      // Ensure we have an ID from URL and a logged-in user
      fetchSingleGardenBed(layoutId);
    } else if (!layoutId) {
      console.warn("MyGardenBed: No layout ID provided in URL.");
      // Optionally redirect or show a message if no layout ID is available
      // navigate('/mygardenbeds'); // Example: redirect to list of all beds
    }
  }, [layoutId, user?.id, fetchSingleGardenBed]); // Dependencies: layoutId, user.id, and the memoized fetch function

  // Find the design name based on the design_type UUID
  const designName =
    styles.find((style) => style.id === currentEditingGardenBed?.design_type)
      ?.design_style_name || "Unknown Design"; // Default if not found or loading

  // --- Render Logic ---
  if (!user.id) {
    return <div>Please log in to view garden beds.</div>;
  }

  if (loadingGardenBeds) {
    return <div>Loading garden bed details...</div>; // Show loading for garden bed
  }

  if (!currentEditingGardenBed) {
    return <div>Garden bed not found or could not be loaded.</div>;
  }

  return (
    <div>
      <h2>Garden Bed: {currentEditingGardenBed.layout_name}</h2>
      <p>ID: {currentEditingGardenBed.id}</p>
      <p>Project ID: {currentEditingGardenBed.projects_id}</p>
      <p>
        Bed Size: {currentEditingGardenBed.bedSize.bedLength}ft x{" "}
        {currentEditingGardenBed.bedSize.bedDepth}ft
      </p>
      <p>Design Type: {designName}</p>

      <h3>Placed Plants:</h3>
      {currentEditingGardenBed.placedPlants &&
      currentEditingGardenBed.placedPlants.length > 0 ? (
        <ul>
          {currentEditingGardenBed.placedPlants.map((plantPlacement) => (
            <li key={plantPlacement.id}>
              {plantPlacement.plant_details?.plant_name} at ({plantPlacement.x},{" "}
              {plantPlacement.y}) (Diameter: {plantPlacement.diameter}ft,
              Height: {plantPlacement.height}ft)
            </li>
          ))}
        </ul>
      ) : (
        <p>No plants placed in this garden bed yet.</p>
      )}

      {/* Pass the currentEditingGardenBed to your GardenCanvas */}
      {/* Ensure GardenCanvas is ready to receive this data */}
      <GardenCanvas bedData={currentEditingGardenBed} />

      {/* Example: Link to add a new plant to this bed */}
      <Link to={`/add-plant-to-bed/${currentEditingGardenBed.id}`}>
        Add Plant
      </Link>
      {/* Example: Link to edit this garden bed */}
      <button
        onClick={() => console.log("Implement edit garden bed functionality")}
      >
        Edit Bed
      </button>
    </div>
  );
};

export default MyGardenBed;
