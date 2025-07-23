import { useContext, useEffect } from "react";
import { GardenPlanContext } from "../context/GardenPlanContext";

export default function GardenBedForm() {
  //local use state for Form
  const [formData, setFormData] = useState({
    bedName: "",
    bedLength: "",
    bedDepth: "",
  });

  return (
    <form>
      <h1>user input here</h1>
    </form>
  );
}
