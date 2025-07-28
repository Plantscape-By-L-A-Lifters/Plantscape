
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
        {plantCatalog.length > 0 ? (
          plantCatalog.map((plant) => (
            <div key={plant.id} className="plantContainer">
              <h3>{plant.plant_name || "Unnamed Plant"}</h3>
              <img
                src={plant.image_url} // Cloudinary image URL
                alt={plant.plant_name}
                className="plant-image"
                onClick={() => setSelectedPlant(plant)}
              />
            </div>
          ))
        ) : (
          <p>No plants found.</p> )}</div> </div>)
        }
  // console.log("full plant catalog", plantCatalog);
  // return (
  //   <div className="plants-container">
  //     <div>
  //       <h1>Creating Your Dream Garden </h1>
  //       <p>Select A Plant!</p>
  //       <br></br>
  //       {loadingPlants ? (
  //         <p>Loading plants...</p>
  //       ) : plantCatalog.length > 0 ? (
  //         <ul>
  //           {plantCatalog.map((plant) => {
  //             // console.log("each plant", plant.plant_name, plant.image_url); // Keep for debugging if needed
  //             return (
  //               <li key={plant.id}>
  //                 {/* Wrap the plant name and image with a Link component */}
  //                 <Link to={`/plants/${plant.id}`}>
  //                   {plant.plant_name || "Unnamed Plant"}
  //                   <img src={plant.image_url} alt={plant.plant_name} />
  //                 </Link>
  //               </li>
  //             );
  //           })}
  //         </ul>
  //       ) : (
  //         <p>No plants found in the catalog.</p> // Message if catalog is empty after loading
       
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

//       {/* Modal for plant details */}
//       {selectedPlant && (
//         <div className="modal" onClick={() => setSelectedPlant(null)}>
//           <div className="modal-content" onClick={(e) => e.stopPropagation()}>
//             <h2>{selectedPlant.plant_name}</h2>
//             <img src={selectedPlant.image_url} alt={selectedPlant.plant_name} className="modal-image" />
//             <p>{selectedPlant.description || "No description available."}</p>
//             <button onClick={() => setSelectedPlant(null)}>Close</button>
//           </div>
//         </div>
//       )}
// >>>>>>> Stashed changes
//     </div>
//   );
// }
