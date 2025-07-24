import { useContext, useEffect } from "react";
import { GardenBedContext } from "../context/GardenBedContext";
import { TemplateSelector } from "../components/TemplateSelector";

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
      <TemplateSelector />
    </form>
  );
}
