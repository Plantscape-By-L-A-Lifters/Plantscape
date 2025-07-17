import { useContext, useEffect } from "react";
import { GardenPlanContext } from "../context/GardenPlanContext";
import GardenCanvas from "../components/canvas/GardenCanvas";

const Results = () => {
  const { setPlacedPlants } = useContext(GardenPlanContext);

  // useEffect(() => {
  //   // Just for testing
  //   setPlacedPlants([
  //     { name: "Coneflower", x: 2, y: 2, spacing: 18, color: "purple" },
  //     { name: "Winecup", x: 4, y: 1, spacing: 12, color: "pink" },
  //   ]);
  // }, []);

  return (
    <div>
      <h2>Garden Layout</h2>
      <GardenCanvas />
    </div>
  );
};

export default Results;
