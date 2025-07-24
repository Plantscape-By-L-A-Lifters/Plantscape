import { useContext, useEffect } from "react";
import { GardenBedContext } from "../context/GardenBedContext";
import GardenCanvas from "../components/canvas/GardenCanvas";
import { Link } from "react-router-dom";

const Results = () => {
  const {} = useContext(GardenBedContext);
  return (
    <div>
      <h2>My Project</h2>
      <p> My Project info here: project name, project id</p>
      <p>
        map through garden beds here (once garden beds have a dynamic link with
        :id)
      </p>
      <Link to="/mygardenbed">My Garden Bed</Link>
    </div>
  );
};

export default Results;
