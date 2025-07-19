import { getScale } from "./getScale";

/**
 *  onComplete - optional callback after animation
 */
export function animateGridLines(
  ctx,
  cols,
  rows,
  bedSize,
  onComplete = () => {}
) {
  const { scale, scaledWidth, scaledHeight } = getScale(bedSize);

  const verticalSpacing = scaledWidth / cols;
  const horizontalSpacing = scaledHeight / rows;

  const drawSpeed = 8; // pixels per frame
  const lineDelay = 200; // ms delay between lines

  const lines = [];

  // Generate vertical lines (skip first and last)
  for (let i = 1; i < cols; i++) {
    const x = i * verticalSpacing;
    lines.push({ x1: x, y1: 0, x2: x, y2: scaledHeight });
  }

  // Generate horizontal lines (skip first and last)
  for (let i = 1; i < rows; i++) {
    const y = i * horizontalSpacing;
    lines.push({ x1: 0, y1: y, x2: scaledWidth, y2: y });
  }

  let currentLine = 0;

  function animateLine({ x1, y1, x2, y2 }, onCompleteLine) {
    const totalLength = Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
    let progress = 0;

    function step() {
      const progressRatio = progress / totalLength;
      const currentX = x1 + (x2 - x1) * progressRatio;
      const currentY = y1 + (y2 - y1) * progressRatio;

      ctx.beginPath();
      ctx.moveTo(x1, y1);
      ctx.lineTo(currentX, currentY);
      ctx.strokeStyle = "gray";
      ctx.lineWidth = 1;
      ctx.stroke();

      progress += drawSpeed;

      if (progress < totalLength) {
        requestAnimationFrame(step);
      } else {
        ctx.beginPath();
        ctx.moveTo(x1, y1);
        ctx.lineTo(x2, y2);
        ctx.stroke();

        setTimeout(onCompleteLine, lineDelay);
      }
    }

    step();
  }

  function drawNext() {
    if (currentLine >= lines.length) {
      onComplete(); // Call final callback if provided
      return;
    }

    animateLine(lines[currentLine++], drawNext);
  }

  drawNext();
}
