import { useContext, useEffect } from "react";
import { PlantLibraryContext } from "../context/PlantLibraryContext";

export default function Plants() {
  return (
    <div>
      <h1>Creating your dream gardens </h1>
      <p> Plant Lists</p>
      <br></br>
      <ul>
        <li>Cedar sedge</li>
        <img src="/public/cedar-sedge.jpg" alt="cedar_sedge" />
        <li>Corn flowers</li>
        <img src="/public/corn_flowers.jpeg" alt="corn_flowers" />
        <li>Elephant Ears</li>
        <img src="/public/Elephant-Ear.jpeg" alt="Elephant-Ear" />
        <li>Lavender </li>
        <img src="/public/lavender.jpeg" alt="lavender" />
        <li>Foam flowers</li>
        <img src="/public/foam flower.jpeg" alt="foamflower" />
        <li>Halone grass</li>
        <img src="/public/hakone_grass.jpeg" alt="hakone_grass" />
        <li>Lamb's Ears</li>
        <img src="/public/lamb's ear.jpeg" alt="lamb's ear" />
        <li>Tea Roses</li>
        <img src="/public/roses.jpeg" alt="roses" />
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
  );
}
