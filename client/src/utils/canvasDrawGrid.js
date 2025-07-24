import { getScale } from "./getScale";

export function drawGrid(ctx, activeBed) {
  if (!activeBed || !activeBed.bedSize) return;

  const { bedLength, bedDepth } = activeBed.bedSize;
  const { scale, scaledWidth, scaledHeight } = getScale(activeBed.bedSize);

  const verticalSpacing = scaledWidth / bedLength;
  const horizontalSpacing = scaledHeight / bedDepth;

  ctx.strokeStyle = "gray";
  ctx.lineWidth = 1;

  // Draw vertical lines
  for (let i = 1; i < cols; i++) {
    const x = i * verticalSpacing;
    ctx.beginPath();
    ctx.moveTo(x, 0);
    ctx.lineTo(x, scaledHeight);
    ctx.stroke();
  }

  // Draw horizontal lines
  for (let j = 1; j < rows; j++) {
    const y = j * horizontalSpacing;
    ctx.beginPath();
    ctx.moveTo(0, y);
    ctx.lineTo(scaledWidth, y);
    ctx.stroke();
  }
}
