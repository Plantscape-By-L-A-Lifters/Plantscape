import { useContext, useState } from "react";
import { Link } from "react-router-dom";
import { PlantCatalogContext } from "../context/PlantCatalogContext";
import "./Plants.css";

export default function Plants() {
  const { plantCatalog, loadingPlants } = useContext(PlantCatalogContext);
  const [selectedPlant, setSelectedPlant] = useState(null);

  return (
    <div className="plants-container">
      <h1>Creating Your Dream Garden</h1>
      <p>Select A Plant!</p>
      <br />
      <div className="plants-grid">
        {loadingPlants ? (
          <p>Loading plants...</p>
        ) : plantCatalog.length > 0 ? (
          plantCatalog.map((plant) => (
            // console.log("each plant", plant.plant_name, plant.image_url); // Keep for debugging
            // <Link to={`/plants/${plant.id}`}>
            <div key={plant.id} className="plantContainer">
              <h3>{plant.plant_name || "Unnamed Plant"}</h3>
              <img
                src={plant.image_url} // Cloudinary image URL
                alt={plant.plant_name}
                className="plant-image"
                onClick={() => setSelectedPlant(plant)}
              />
            </div>
            // </Link>
          ))
        ) : (
          <p>No plants found.</p>
        )}
      </div>{" "}
      {/* Modal for plant details */}
      {selectedPlant && (
        <div className="modal" onClick={() => setSelectedPlant(null)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <h2>{selectedPlant.plant_name}</h2>
            <img
              src={selectedPlant.image_url}
              alt={selectedPlant.plant_name}
              className="modal-image"
            />
            {selectedPlant.sun_requirements && (
              <p>{selectedPlant.sun_requirements}</p>
            )}
            {selectedPlant.is_toxic ? (
              <p style={{ fontStyle: "italic" }}>toxic</p>
            ) : (
              <p>non-toxic</p>
            )}

            <p>
              <Link to={`/plants/${selectedPlant.id}`}>more details...</Link>
            </p>
            {/* <button onClick={() => setSelectedPlant(null)}>Close</button> */}
          </div>
        </div>
      )}
    </div>
  );
}

/* <div>
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
            <p></p>
          </footer>
        </div> */
//       </div>
