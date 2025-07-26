import { useContext, useEffect } from "react";
import { useParams, Link } from "react-router-dom"; // Import useParams to get ID from URL
import { UserContext } from "../context/UserContext"; // Adjust path if your contexts are in a different folder
import { ProjectContext } from "../context/ProjectContext"; // Adjust path
import { GardenBedContext } from "../context/GardenBedContext"; // Keep if needed for garden beds

// Renamed from 'Results' to 'MyProject' for clarity based on file name
const MyProject = () => {
  // Destructure necessary values from contexts
  const { user } = useContext(UserContext);
  const {
    currentEditingProject, // The detailed project object fetched by fetchProject
    fetchProject, // Function to fetch a single project by ID
    activeProjectId, // The ID of the project selected from a list (optional, but useful)
    setActiveProjectId, // Function to set the active project ID (optional)
  } = useContext(ProjectContext);

  // If you still need GardenBedContext for this component:
  const {
    /* garden bed related state/functions */
  } = useContext(GardenBedContext);

  // Get the project ID from the URL parameters
  // Assuming your route is something like <Route path="/myproject/:projectId" element={<MyProject />} />
  const { projectId } = useParams();

  // useEffect to fetch the specific project when the component mounts or projectId changes
  useEffect(() => {
    // Determine which project ID to fetch: URL param has priority, then activeProjectId
    const idToFetch = projectId || activeProjectId;

    if (idToFetch && user?.id) {
      // Ensure we have an ID and a logged-in user
      fetchProject(idToFetch);
      // Optional: If the URL param is different from activeProjectId, update activeProjectId
      if (projectId && projectId !== activeProjectId) {
        setActiveProjectId(projectId);
      }
    } else if (!idToFetch) {
      console.warn(
        "MyProject: No project ID provided in URL or activeProjectId."
      );
      // Optionally redirect or show a message if no project ID is available
    }
  }, [projectId, activeProjectId, user?.id, fetchProject, setActiveProjectId]); // Add fetchProject to deps

  // --- Render Logic ---
  if (!user.id) {
    return <div>Please log in to view your projects.</div>;
  }

  if (!currentEditingProject) {
    // You might want a loading spinner here
    return <div>Loading project details...</div>;
  }

  // Display the detailed project information
  return (
    <div>
      <h2>My Project: {currentEditingProject.project_name}</h2>
      <p>Project ID: {currentEditingProject.id}</p>
      <p>Owner: {user.username}</p> {/* Display owner from UserContext */}
      {/* Display other project details from currentEditingProject */}
      {currentEditingProject.description && (
        <p>Description: {currentEditingProject.description}</p>
      )}
      {/* Add more details of the project as needed */}
      <h3>Garden Beds:</h3>
      {/*
        Map through garden beds here.
        You'll need to ensure currentEditingProject includes garden bed data,
        or fetch garden beds separately using GardenBedContext if they are related to currentEditingProject.
        Example: currentEditingProject.gardenBeds.map(...)
      */}
      <p>
        (Garden bed mapping will go here once garden beds have a dynamic link
        with :id or are part of the project object)
      </p>
      <Link to="/newgardenbed">Add New Garden Bed</Link>
      {/* <Link to={`/mygardenbed/${/garden_bed_id/}`}>View Garden Bed</Link>*/}
      {/* Add buttons or forms for editing the project */}
      <button
        onClick={() => console.log("Implement edit project functionality")}
      >
        Edit Project
      </button>
      {/* ... other actions like delete project */}
    </div>
  );
};

export default MyProject; // Export as MyProject
