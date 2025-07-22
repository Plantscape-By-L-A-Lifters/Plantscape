import { createContext, useState, useEffect } from "react";

export const DesignStyleContext = createContext();

const defaultStyles = [
  {
    id: 1,
    name: "Classical",
    gridMinCols: 4,
    // gridEven: true,
    spacingFactor: 1.2,
  },
  {
    id: 2,
    name: "Modern",
    gridMinCols: 3,
    // gridOdd: true,
    spacingFactor: 1.4,
  },
  {
    id: 3,
    name: "Cottage",
    gridMinCols: 3,
    spacingFactor: 1.0,
  },
];

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
