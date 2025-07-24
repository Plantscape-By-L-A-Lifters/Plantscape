import { useContext } from "react";
import { GardenBedContext } from "../context/GardenBedContext";

export function TemplateSelector() {
  const { exampleBeds, createBedFromTemplate } = useContext(GardenBedContext);

  return (
    <div>
      <h2>Select a Template</h2>
      {exampleBeds.map((bed) => (
        <div key={bed.id}>
          <h3>{bed.name}</h3>
          <button onClick={() => createBedFromTemplate(bed)}>
            Use This Template
          </button>
        </div>
      ))}
    </div>
  );
}
