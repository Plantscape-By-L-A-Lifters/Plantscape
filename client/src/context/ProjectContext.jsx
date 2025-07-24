// context/ProjectContext.jsx
import { createContext, useState, useEffect } from "react";
import axios from "axios";

export const ProjectContext = createContext();

export const ProjectProvider = ({ children }) => {
  const [projects, setProjects] = useState([]);
  const [activeProjectId, setActiveProjectId] = useState(null);

  useEffect(() => {
    const fetchProjects = async () => {
      try {
        const { data } = await axios.get("/api/projects");
        setProjects(data);
        if (data.length > 0 && !activeProjectId) {
          setActiveProjectId(data[0].id); // Default to first project
        }
      } catch (err) {
        console.error("Failed to fetch projects", err);
      }
    };
    fetchProjects();
  }, []);

  const activeProject = projects.find((p) => p.id === activeProjectId);

  return (
    <ProjectContext.Provider
      value={{
        projects,
        setProjects,
        activeProjectId,
        setActiveProjectId,
        activeProject,
      }}
    >
      {children}
    </ProjectContext.Provider>
  );
};

//Use it in Components:
// import { useContext } from "react";
// import { ProjectContext } from "../context/ProjectContext";

// const { projects, activeProject, setActiveProjectId } = useContext(ProjectContext);
