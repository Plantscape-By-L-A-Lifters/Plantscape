import { Canvas } from "../components/canvas";

export default function MyProject() {
  bedWidth = 6; //placeholder entered in feet
  bedHeight = 4; //placeholder entered in feet

  const canvasWidth = bedWidth * 10; //will need if statement for large/small beds
  const canvasHeight = bedHeight * 10;
  return (
    <div>
      <Canvas width={canvasWidth} height={canvasHeight} />
    </div>
  );
}
