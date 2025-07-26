import { createContext, useState, useEffect, useContext } from "react";
import axios from "axios";
import { UserContext } from "./UserContext";

export const ProjectContext = createContext();

export const ProjectProvider = ({ children }) => {
  const [projects, setProjects] = useState([]); // State for all projects for the user (list view)
  const [activeProjectId, setActiveProjectId] = useState(null); // ID of the currently selected project (e.g., in a list)
  const [currentEditingProject, setCurrentEditingProject] = useState(null); // State for the detailed project being edited/viewed

  const { user, getHeaders } = useContext(UserContext);

  const fetchProjects = async () => {
    // Only fetch if a user ID exists and we have headers (meaning a token is likely present)
    // getHeaders().headers?.authorization checks if the authorization header exists
    if (!user?.id || !getHeaders().headers?.authorization) {
      setProjects([]); // Clear projects if no user is logged in or no token
      setActiveProjectId(null); // Also clear active project
      setCurrentEditingProject(null); // Clear editing project
      return;
    }
    try {
      // Use getHeaders for authenticated API call
      const { data } = await axios.get(
        `/api/projects/MyProjects/`,
        getHeaders()
      );
      setProjects(data);
      // Set default active project if none is selected and projects exist
      if (data.length > 0 && !activeProjectId) {
        setActiveProjectId(data[0].id); // Default to first project
      }
    } catch (err) {
      console.error("Failed to fetch projects:", err);
      setProjects([]); // Clear projects on error
      setActiveProjectId(null); // Clear active project on error
      setCurrentEditingProject(null); // Clear editing project on error
    }
  };

  const fetchProject = async (projectId) => {
    if (!projectId || !getHeaders().headers?.authorization) {
      setCurrentEditingProject(null);
      return;
    }
    try {
      // This calls the backend route GET /api/projects/:projectId
      const { data } = await axios.get(
        `/api/projects/${projectId}`,
        getHeaders()
      );
      setCurrentEditingProject(data); // Set the fetched project as the current editing project
      console.log("Fetched single project:", data);
      return data; // Return the fetched project data
    } catch (error) {
      console.error(
        `Failed to fetch single project with ID ${projectId}:`,
        error
      );
      setCurrentEditingProject(null); // Clear on error
      throw error; // Re-throw for component to handle
    }
  };

  // useEffect to call fetchProjects whenever user.id or getHeaders changes
  // This ensures projects are re-fetched when a user logs in/out or their state changes
  useEffect(() => {
    fetchProjects();
  }, [user.id, getHeaders]);

  const addProject = async (projectData) => {
    try {
      // The backend now attaches req.user.id, so sending user_id from frontend is redundant but harmless.
      // Keeping it for now, but backend's req.user.id is the source of truth for security.
      const { data: newProject } = await axios.post(
        "/api/projects",
        projectData,
        getHeaders()
      );
      setProjects((prev) => [...prev, newProject]); // Add to the list of projects
      setActiveProjectId(newProject.id); // Set the newly created project as active
      console.log("Project added successfully:", newProject);
      return newProject;
    } catch (error) {
      console.error("Failed to add project:", error);
      throw error;
    }
  };

  // Derived state: activeProject is found from the list of all projects
  const activeProject = projects.find((p) => p.id === activeProjectId);

  return (
    <ProjectContext.Provider
      value={{
        projects,
        setProjects, // Expose setProjects if components need to directly modify the list
        activeProjectId,
        setActiveProjectId,
        activeProject,
        currentEditingProject, // The detailed project object fetched by fetchProject
        fetchProject, // New function to fetch a single project by ID
        addProject,
        fetchProjects, // Function to re-fetch all projects for the user
      }}
    >
      {children}
    </ProjectContext.Provider>
  );
};

//How to use it in Components:
// import { useContext } from "react";
// import { ProjectContext } from "../context/ProjectContext";

// const { projects, activeProject, setActiveProjectId } = useContext(ProjectContext);
