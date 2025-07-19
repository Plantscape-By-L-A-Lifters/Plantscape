/**
 * Returns the scale (pixels per foot) and derived dimensions
 * @param {Object} bedSize - { length: number, depth: number }
 * @returns {Object} - { scale, scaledWidth, scaledHeight }
 */
export function getScale(bedSize) {
  const scale = bedSize.length > 8 ? 60 : 80;
  const scaledWidth = bedSize.length * scale;
  const scaledHeight = bedSize.depth * scale;

  return { scale, scaledWidth, scaledHeight };
}
