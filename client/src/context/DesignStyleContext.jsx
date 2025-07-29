import { createContext, useState, useEffect } from "react";
import axios from "axios"; // Import axios for API calls

export const DesignStyleContext = createContext();

export const DesignStyleProvider = ({ children }) => {
  const [styles, setStyles] = useState([]);
  const [selectedStyle, setSelectedStyle] = useState(null); // user-selected style

  useEffect(() => {
    const fetchStyles = async () => {
      try {
        const { data } = await axios.get("/api/design");
        setStyles(data);
        if (data.length > 0 && !selectedStyle) {
          setSelectedStyle(data[0].id); // Default to the ID of the first design style
        }
      } catch (err) {
        console.error("Failed to fetch design styles:", err);
      }
    };

    fetchStyles();
  }, [selectedStyle]);

  return (
    <DesignStyleContext.Provider
      value={{ styles, selectedStyle, setSelectedStyle }}
    >
      {children}
    </DesignStyleContext.Provider>
  );
};
