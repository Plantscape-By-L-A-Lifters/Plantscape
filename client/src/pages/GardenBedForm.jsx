import { useContext, useEffect, useState } from "react";
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
      <h1>Please choose a template garden bed to get started:</h1>
      <TemplateSelector />
    </form>
  );
}
