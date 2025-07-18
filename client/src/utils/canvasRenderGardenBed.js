import { animateGridLines } from "./canvasGridAnimation";
import { drawPlantsAtGridIntersections } from "./canvasDrawPlants";

export function renderGardenBed(ctx, width, height, cols, rows, plants) {
  animateGridLines(ctx, width, height, cols, rows, () => {
    drawPlantsAtGridIntersections(ctx, width, height, cols, rows, plants);
  });
}
