import { createContext, useContext, useState } from "react";
import { gardenBedTemplates } from "../data/gardenBedTemplates";

export const GardenBedContext = createContext();

export const GardenBedProvider = ({ children }) => {
  const [gardenBeds, setGardenBeds] = useState([]);
  const [exampleBeds, setExampleBeds] = useState(gardenBedTemplates);

  const createBedFromTemplate = (template) => {
    const newBed = {
      ...template,
      id: crypto.randomUUID(),
      name: `${template.name} Copy`,
      isTemplate: false,
    };
    setGardenBeds((prev) => [...prev, newBed]);
  };

  return (
    <GardenBedContext.Provider
      value={{ gardenBeds, setGardenBeds, exampleBeds, createBedFromTemplate }}
    >
      {children}
    </GardenBedContext.Provider>
  );
};
