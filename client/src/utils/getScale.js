/**
 * Returns the scale (pixels per foot) and derived dimensions
 * @param {Object} bedSize - { bedLength: number, bedDepth: number }
 * @returns {Object} - { scale, scaledWidth, scaledHeight }
 */
export function getScale(bedSize) {
  console.log("Received bedSize in getScale:", bedSize);

  const scale = bedSize.bedLength > 8 ? 60 : 80;
  const scaledWidth = bedSize.bedLength * scale;
  const scaledHeight = bedSize.bedDepth * scale;

  return { scale, scaledWidth, scaledHeight };
}
