import { drawGrid } from "./canvasDrawGrid";
import { animatePlants } from "./canvasAnimatePlants";
import { getScale } from "../utils/getScale";

export function renderGardenBed(ctx, activeBed) {
  if (!activeBed || !activeBed.bedSize || !activeBed.placedPlants) return;

  const { bedSize, placedPlants } = selectedBed;
  const { bedLength, bedDepth } = bedSize;
  const { scaledWidth, scaledHeight } = getScale(bedSize);

  console.log("Drawing garden bed:", {
    scaledWidth,
    scaledHeight,
    placedPlants,
  });

  ctx.clearRect(0, 0, scaledWidth, scaledHeight);
  ctx.fillStyle = "white";
  ctx.fillRect(0, 0, scaledWidth, scaledHeight);

  drawGrid(ctx, bedLength, bedDepth, bedSize);
  animatePlants(ctx, activeBed); // Pass full selectedBed to animatePlants
}
