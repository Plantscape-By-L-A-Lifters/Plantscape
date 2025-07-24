import { createContext, useContext, useEffect, useState } from "react";
import { gardenBedTemplates } from "../data/gardenBedTemplates";
import { sampleGardenBeds } from "../data/sampleGardenBeds";

export const GardenBedContext = createContext();

export const GardenBedProvider = ({ children }) => {
  const [gardenBeds, setGardenBeds] = useState([]);
  const [exampleBeds, setExampleBeds] = useState(gardenBedTemplates);
  const [activeBed, setActiveBed] = useState(null);

  // For convenience, expose these separately from activeBed
  const bedSize = activeBed?.bedSize || { bedLength: 0, bedDepth: 0 };
  const placedPlants = activeBed?.placedPlants || [];

  const createBedFromTemplate = (template) => {
    const newBed = {
      ...template,
      id: crypto.randomUUID(),
      name: `${template.name} Copy`,
      isTemplate: false,
    };
    setGardenBeds((prev) => [...prev, newBed]);
  };

  useEffect(() => {
    //TODO:replace with API call
    setGardenBeds(sampleGardenBeds);
    setActiveBed(sampleGardenBeds[0]); // default selected
  }, []);

  return (
    <GardenBedContext.Provider
      value={{
        gardenBeds,
        setGardenBeds,
        exampleBeds,
        createBedFromTemplate,
        activeBed,
        setActiveBed,
        bedSize,
        placedPlants,
      }}
    >
      {children}
    </GardenBedContext.Provider>
  );
};

//how to use it in components
// import { useContext } from "react";
// import { GardenBedContext } from "../context/GardenBedContext";

// const { bedSize, placedPlants } = useContext(GardenBedContext);

//example of how to update data in setActiveBed:
// setActiveBed({
//   ...activeBed,
//   placedPlants: updatedPlantList,
// });
