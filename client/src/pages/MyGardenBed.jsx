import { useContext, useEffect } from "react";
import { GardenBedContext } from "../context/GardenBedContext";
import GardenCanvas from "../components/canvas/GardenCanvas";

const Results = () => {
  const { exampleBeds, setPlacedPlants, setBedSize } =
    useContext(GardenBedContext);

  useEffect(() => {
    // Just for testing
    try {
      setBedSize({ bedLength: 12, bedDepth: 6 });
      setPlacedPlants(...exampleBeds[0]);
    } catch (error) {
      console.log(error);
    }
  }, []);

  return (
    <div>
      <h2>Garden Layout</h2>
      <GardenCanvas />
    </div>
  );
};

export default Results;
