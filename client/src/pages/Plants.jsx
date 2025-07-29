import { useContext, useState } from "react";
import { Link } from "react-router-dom";
import { PlantCatalogContext } from "../context/PlantCatalogContext";
import { UserContext } from '../context/UserContext';
import "./Plants.css";



export default function Plants() {
  const { user} = useContext(UserContext);
  const { plantCatalog, loadingPlants, addFavePlant } = useContext(PlantCatalogContext);
  const [selectedPlant, setSelectedPlant] = useState(null);

  // Filter out plants that do not have a valid image_url
  const renderablePlants = plantCatalog.filter(
    (plant) => plant.image_url && plant.image_url.trim() !== ""
  );

  return (
    <div className="plants-container">
      <h1>Creating Your Dream Garden</h1>
      <p>Select A Plant!</p>
      <br />
      <div className="plants-grid">
        {loadingPlants ? (
          <p>Loading plants...</p>
        ) : renderablePlants.length > 0 ? ( // Use renderablePlants here
          renderablePlants.map(
            (
              plant // Map over renderablePlants
            ) => (
              <div key={plant.id} className="plantContainer">
                <h3>{plant.plant_name || "Unnamed Plant"}</h3>
                <hr />
                <img
                  src={plant.image_url} // Cloudinary image URL
                  alt={plant.plant_name}
                  className="plant-image"
                  onClick={() => setSelectedPlant(plant)}
                />
              </div>
              // </Link>
            )
          )
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
             {user ? (
                 <button onClick={() => addFavePlant(selectedPlant.id)}>Favorite</button>
              ) : null}
            {/* <button onClick={() => setSelectedPlant(null)}>Close</button> */}
          </div>
        </div>
      )}

    </div>
  );
}
