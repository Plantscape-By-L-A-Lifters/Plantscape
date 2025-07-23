import { drawGrid } from "./canvasDrawGrid";
import { animatePlants } from "./canvasAnimatePlants";
import { getScale } from "../utils/getScale";

export function renderGardenBed(ctx, cols, rows, placedPlants, bedSize) {
  if (
    !bedSize ||
    typeof bedSize.bedLength !== "number" ||
    typeof bedSize.bedDepth !== "number" ||
    !Array.isArray(placedPlants)
  ) {
    console.warn(
      "renderGardenBed: Invalid bedSize or placedPlants",
      bedSize,
      placedPlants
    );
    return;
  }
  const { scaledWidth, scaledHeight } = getScale(bedSize);

  console.log("Drawing garden bed:", {
    scaledWidth,
    scaledHeight,
    placedPlants,
  });

  ctx.clearRect(0, 0, scaledWidth, scaledHeight);
  ctx.fillStyle = "white";
  ctx.fillRect(0, 0, scaledWidth, scaledHeight);

  drawGrid(ctx, cols, rows, bedSize);
  animatePlants(ctx, cols, rows, placedPlants, bedSize);
}
