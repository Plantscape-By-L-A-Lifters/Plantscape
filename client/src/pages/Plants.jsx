import { useContext } from "react";
import { PlantCatalogContext } from "../context/PlantCatalogContext";
import "./plants.css";

export default function Plants() {
  const { plantCatalog } = useContext(PlantCatalogContext);
  // console.log("full plant catalog", plantCatalog);
  return (
    <div className="plants-container">
      <div>
        <h1>Creating Your Dream Garden </h1>
        <p>Select A Plant!</p>
        <br></br>
        <ul>
          {plantCatalog.length > 0 ? (
            plantCatalog.map((plant) => {
              console.log("each plant", plant.plant_name, plant.image_url);
              return (
                <li key={plant.id}>
                  {plant.plant_name || "Unnamed Plant"}
                  <img src={plant.image_url} alt={plant.plant_name} />
                </li>
              );
            })
          ) : (
            <p>No plant found</p>
          )}
        </ul>
        <div>
          <ul>
            <li>
              Cedar sedge
              <img src="/cedar-sedge.jpg" alt="cedar_sedge" />
            </li>
            <li>
              Corn flowers
              <img src="/corn_flowers.jpeg" alt="corn_flowers" />
            </li>
            <li>
              Elephant Ears
              <img src="/Elephant-Ear.jpeg" alt="Elephant-Ear" />
            </li>
            <li>
              Lavender
              <img src="/lavender.jpeg" alt="lavender" />
            </li>
            <li>
              Foam flowers
              <img src="/foam flower.jpeg" alt="foamflower" />
            </li>
            <li>
              Halone grass
              <img src="/hakone_grass.jpeg" alt="hakone_grass" />
            </li>
            <li>
              Lamb's Ears
              <img src="/lamb's ear.jpeg" alt="lamb's ear" />
            </li>
            <li>
              Tea Roses
              <img src="/roses.jpeg" alt="roses" />
            </li>
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
    </div>
  );
}
