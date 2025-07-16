
import React, { useState } from 'react';



const gardenStyles = [
  {
    name: "Classical",
    style: "Formal",
    features: ["Symmetry", "Structured layout", "Low hedges", "Gravel paths"],
    planting: "Neatly trimmed, layered"
  },
  {
    name: "Modern",
    style: "Clean and minimal",
    features: ["Geometric layout", "Lawn with pavers", "Simple hardscape"],
    planting: "Sculptural plants, minimal color palette"
  },
  {
    name: "Cottagecore",
    style: "Romantic and wild",
    features: ["Natural shapes", "Dense planting", "Whimsical feel"],
    planting: "Clumping, lots of colors, large variety"
  },
  {
    name: "Modern Lush",
    style: "Modern + Dense Planting",
    features: ["Toned down palette", "Modern layout", "Cottage-style density"],
    planting: "Monochrome tones, dense layout like cottagecore"
  }
];

export default function stylequiz() {
  const [selectedStyle, setSelectedStyle] = useState(null);

  const handleSelect = (style) => {
    setSelectedStyle(style);
  };

  const handleBack = () => {
    setSelectedStyle(null);
  };

  return (
    <div className="picker-container">
      <h1>  Garden Style   </h1>

      {selectedStyle ? (
        <div className="details">
          <button onClick={handleBack}>← Back</button>
          <h2>{selectedStyle.name}</h2>
          <p><strong>Style:</strong> {selectedStyle.style}</p>
          <p><strong>Features:</strong> {selectedStyle.features.join(", ")}</p>
          <p><strong>Planting:</strong> {selectedStyle.planting}</p>
        </div>
      ) : (
        <div className="gallery">
          {gardenStyles.map((style) => (
            <div
              className="card"
              key={style.name}
              onClick={() => handleSelect(style)}
            >
            
<img src="/public/classical.jpg" alt="Classical" />

<br></br>

<img src="/public/modern.jpeg" alt="Modern" />

<br></br>

<img src="/public/cottage.jpg" alt="Cottage" />

<br></br>

<img src="/public/modernlush.jpg" alt="ModernLush" />

<br></br> 
              <h3>{style.name}</h3>
            </div>
          ))}
        </div>
)}
</div>
);
}


 