import { useContext, useEffect } from "react";
import { GardenPlanContext } from "../context/GardenPlanContext";
import GardenCanvas from "../components/canvas/GardenCanvas";

const Results = () => {
  const { setPlacedPlants, setBedSize } = useContext(GardenPlanContext);

  useEffect(() => {
    // Just for testing
    setPlacedPlants([
      {
        id: 25,
        name: "Japanese Painted Fern",
        technical_name: "Athyrium niponicum var. pictum",
        diameter_min_ft: 1,
        diameter_max_ft: 1.5,
        height_min_ft: 1,
        height_max_ft: 1.5,
        color: "purple-brown",
        accent_color: "pale_green",
      },
      {
        id: 29,
        name: "Foamflower",
        technical_name: "Tiarella cordifolia",
        diameter_min_ft: 1,
        diameter_max_ft: 2,
        height_min_ft: 0.5,
        height_max_ft: 1,
        image: "../../public/foamflower.jpg",
        icon: "/icons/foamflower.jpg",
        shape: "circle",
        accent_color: "white",
        color: "lime_green",
      },
    ]);
  }, []);

  return (
    <div>
      <h2>Garden Layout</h2>
      <GardenCanvas />
    </div>
  );
};

export default Results;
