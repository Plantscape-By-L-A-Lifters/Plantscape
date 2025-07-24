import { useContext, useEffect } from "react";
import { GardenBedContext } from "../context/GardenBedContext";
import GardenCanvas from "../components/canvas/GardenCanvas";

const MyGardenBed = () => {
  const { templateBeds, setActiveBed } = useContext(GardenBedContext);

  useEffect(() => {
    // Just for testing: load the first template bed as the selected bed
    try {
      const testBed = templateBeds[0];
      if (testBed) {
        setActiveBed(testBed);
      }
    } catch (error) {
      console.error("Failed to set selected bed:", error);
    }
  }, [templateBeds, setActiveBed]);

  return (
    <div>
      <h2>Garden Layout</h2>
      <GardenCanvas />
    </div>
  );
};

export default MyGardenBed;
