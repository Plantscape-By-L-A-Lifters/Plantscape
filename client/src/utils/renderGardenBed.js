import { animateGridLines } from "./canvasGridAnimation";
import { drawPlacedPlants } from "./canvasDrawPlants";
import { getScale } from "../utils/getScale";

export function renderGardenBed(ctx, cols, rows, placedPlants, bedSize) {
  const { scale, scaledWidth, scaledHeight } = getScale(bedSize);
  console.log(
    "Drawing garden bed length",
    scaledWidth,
    "and height",
    scaledHeight,
    "with",
    placedPlants.length,
    "plants"
  );
  placedPlants.forEach((plant) => {
    console.log(`Rendering plant at (${plant.x}, ${plant.y})`);
  });

  animateGridLines(ctx, cols, rows, bedSize, () => {
    drawPlacedPlants(ctx, cols, rows, placedPlants, bedSize);
  });
}
