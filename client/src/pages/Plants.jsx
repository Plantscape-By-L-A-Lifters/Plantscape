import { useContext } from "react";
import { PlantCatalogContext } from "../context/PlantCatalogContext";

export default function Plants() {
  const { plantCatalog } = useContext(PlantCatalogContext);
  // console.log("full plant catalog", plantCatalog);
  return (
    <div>
      <h1>Creating your dream gardens </h1>
      <p>Plant Lists</p>
      <br></br>
      <div>
        {plantCatalog.length > 0 ? (
          plantCatalog.map((plant) => {
            // console.log("each plant", plant.name, plant.id);
            return (
              <div key={plant.id} className="plantContainer">
                <h3>{plant.plant_name || "Unnamed Plant"}</h3>
              </div>
            );
          })
        ) : (
          <p>Loading plants...</p>
        )}
      </div>
      <div>
        <ul>
          <li>Cedar sedge</li>
          <img src="/cedar-sedge.jpg" alt="cedar_sedge" />
          <li>Corn flowers</li>
          <img src="/corn_flowers.jpeg" alt="corn_flowers" />
          <li>Elephant Ears</li>
          <img src="/Elephant-Ear.jpeg" alt="Elephant-Ear" />
          <li>Lavender </li>
          <img src="/lavender.jpeg" alt="lavender" />
          <li>Foam flowers</li>
          <img src="/foam flower.jpeg" alt="foamflower" />
          <li>Halone grass</li>
          <img src="/hakone_grass.jpeg" alt="hakone_grass" />
          <li>Lamb's Ears</li>
          <img src="/lamb's ear.jpeg" alt="lamb's ear" />
          <li>Tea Roses</li>
          <img src="/roses.jpeg" alt="roses" />
        </ul>
        <br></br>
        <h2>Characteristics </h2>
        <ul>
          <li>Symmetrical layout and geometric patterns</li>
          <li>Well-manicured hedges and topiaries</li>
          <li>Straight pathways and axial design</li>
          <li>Use of evergreen plants for year-round structure</li>
          <li>Formal water features like fountains or reflecting pools</li>
          <li>Ornamental elements such as statues or urns</li>
        </ul>
        <br></br>
        <h3>Maintenance Tips</h3>
        <ul>
          <li>Regular pruning to maintain shapes</li>
          <li>Frequent edging for crisp lines</li>
          <li>Seasonal replanting of annuals</li>
          <li>Weed control for clean appearance</li>
        </ul>
        <br></br>
        <footer>
          <p>© 2025 Gardenia.net. All rights reserved.</p>
        </footer>
      </div>
    </div>
  );
}
