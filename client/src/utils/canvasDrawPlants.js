import { getScale } from "./getScale";

export function drawPlacedPlants(ctx, cols, rows, placedPlants, bedSize) {
  const { scale, scaledWidth, scaledHeight } = getScale(bedSize);

  const verticalSpacing = scaledWidth / cols;
  const horizontalSpacing = scaledHeight / rows;

  for (const plant of placedPlants) {
    const x = plant.x * verticalSpacing;
    const y = plant.y * horizontalSpacing;

    const diameterFt = plant.diameter ?? 1;
    const radiusPx = (diameterFt * scale) / 2;

    const fillColor = plant.color || "rgba(34,139,34,0.6)";
    const strokeColor = plant.accent_color || "green";

    ctx.beginPath();
    ctx.arc(x, y, radiusPx, 0, 2 * Math.PI);
    ctx.fillStyle = fillColor;
    ctx.fill();
    ctx.strokeStyle = strokeColor;
    ctx.lineWidth = 2;
    ctx.stroke();
  }
}

//in the long term, id like to be able to reference the grid lines created in the grid animation file to place the plants, but they will not always be snapped to the grid center points.

//previous code before simplifying back to x,y coordinates
// import { getScale } from "./getScale";

// export function drawPlantsAtGridIntersections(
//   ctx,
//   width,
//   height,
//   cols,
//   rows,
//   plants
// ) {
//   const verticalSpacing = width / cols;
//   const horizontalSpacing = height / rows;
//   const scale = getScale(width);

//   function getHexCode(colorName, colorsArray) {
//     const match = colorsArray.find((c) => c.name === colorName);
//     return match ? match.hexCode : "#000000"; // default black fallback
//   }

//   for (let i = 1; i < cols; i++) {
//     for (let j = 1; j < rows; j++) {
//       const x = i * verticalSpacing;
//       const y = j * horizontalSpacing;

//       const plant = plants[Math.floor(Math.random() * plants.length)];
//       const avgDiameterFt = (plant.diameter_min_ft + plant.diameter_max_ft) / 2;
//       const radiusPx = (avgDiameterFt * scale) / 2;
//       console.log(radiusPx);

//       const fillColor = plant.color || "rgba(34,139,34,0.6)";
//       const strokeColor = plant.accent_color || "green";

//       ctx.beginPath();
//       ctx.arc(x, y, radiusPx, 0, 2 * Math.PI);
//       ctx.fillStyle = fillColor;
//       ctx.fill();
//       ctx.strokeStyle = strokeColor;
//       ctx.lineWidth = 2;
//       ctx.stroke();
//     }
//   }
// }
