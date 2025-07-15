import Canvas from "../components/canvas/script";

export default function MyProject() {
  let bedWidth = 6; //placeholder entered in feet
  let bedHeight = 4; //placeholder entered in feet
  let scaleFactor = 100;
  const canvasWidth = bedWidth * scaleFactor; //will need if statement for large/small beds
  const canvasHeight = bedHeight * scaleFactor;

  return (
    <div>
      <Canvas width={canvasWidth} height={canvasHeight} />
    </div>
  );
}
