import { useContext, useEffect } from "react";
import { GardenBedContext } from "../context/GardenBedContext";
import GardenCanvas from "../components/canvas/GardenCanvas";

const MyGardenBed = () => {
  const { templateBeds, activeBed, setActiveBed } =
    useContext(GardenBedContext);

  useEffect(() => {
    // Just for testing: load the first template bed as the selected bed
    try {
      const testBed = templateBeds[0];
      console.log("First template bed:", testBed);
      if (testBed) {
        setActiveBed(testBed);
      }
    } catch (error) {
      console.error("Failed to set selected bed:", error);
    }
  }, [templateBeds, setActiveBed]);

  if (!templateBeds.length) {
    return <p>Loading beds...</p>;
  }
  return (
    <div>
      <h2>Garden Layout</h2>
      {activeBed && <h3>Viewing: {activeBed.name}</h3>}
      <GardenCanvas />
    </div>
  );
};

export default MyGardenBed;
