import { createContext, useState, useEffect } from "react";

export const DesignStyleContext = createContext();

//TODO
// useEffect(() => {
//   const fetchProjects = async () => {
//     try {
//       const { data } = await axios.get("/api/projects");
//       setProjects(data);
//       if (data.length > 0 && !activeProjectId) {
//         setActiveProjectId(data[0].id); // Default to first project
//       }
//     } catch (err) {
//       console.error("Failed to fetch projects", err);
//     }
//   };
//   fetchProjects();
// }, []);

export const DesignStyleProvider = ({ children }) => {
  const [styles, setStyles] = useState(defaultStyles);
  const [selectedStyle, setSelectedStyle] = useState(null); // user-selected

  return (
    <DesignStyleContext.Provider
      value={{ styles, selectedStyle, setSelectedStyle }}
    >
      {children}
    </DesignStyleContext.Provider>
  );
};
