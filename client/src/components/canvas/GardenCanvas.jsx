import { useRef, useEffect, useContext } from "react";
import { GardenPlanContext } from "../../context/GardenPlanContext";

export default function GardenCanvas() {
  const canvasRef = useRef(null);
  const { bedSize, placedPlants } = useContext(GardenPlanContext);

  useEffect(() => {
    const canvas = canvasRef.current;

    const ctx = canvas.getContext("2d");

    const getScale = (bedSize) => {
      return bedSize.length > 8 ? 60 : 80;
    }; //80; //1 foot = 80px //TODO: needs to be flexible based on screen size and garden bed size
    const scale = getScale(bedSize);

    const width = bedSize.length * scale;
    const height = bedSize.depth * scale;

    //set canvas dimensions
    canvas.width = width;
    canvas.height = height;

    //clear canvas
    ctx.clearRect(0, 0, width, height);

    //draw bed outline
    ctx.strokeStyle = "black";
    ctx.lineWidth = 1;
    ctx.strokeRect(0, 0, width, height);

    //find the center of the canvas
    const centerX = width / 2;
    const centerY = height / 2;

    //determine grid spacing
    function gridSpacingX(numCx) {
      return Math.floor(width / numCx);
    }

    function gridSpacingY(numCy) {
      return Math.floor(height / numCy);
    }

    function isOdd(number) {
      return Math.abs(number % 2) === 1;
    }

    // Draw each plant as a circle
    placedPlants.forEach((plant) => {
      const x = plant.x * scale;
      const y = plant.y * scale;
      const radius = (plant.spacing / 2) * scale;

      ctx.beginPath();
      ctx.arc(x, y, radius, 0, 2 * Math.PI);
      ctx.fillStyle = plant.color || "green";
      ctx.fill();
      ctx.stroke();
    });
  }, [bedSize, placedPlants]);

  return (
    <canvas
      ref={canvasRef}
      style={{ border: "1px solid #ccc", marginTop: "1rem" }}
    />
  );
}

// my previous Work
//     //find the center of the canvas
//     const centerX = width / 2;
//     const centerY = height / 2;

//     function isOdd(number) {
//       return Math.abs(number % 2) === 1; // Use Math.abs for consistent handling of negative numbers
//     }

//     //determine spacing
//     function spacingX(numCx) {
//       return Math.floor(width / numCx);
//     }

//     function spacingY(numCy) {
//       return Math.floor(height / numCy);
//     }

//     function remainderX(numCx) {
//       return width % numCx;
//     }

//     function remainderY(numCy) {
//       return height % numCy;
//     }
//     //if isOdd(spacingX) {setOffCenter}}
//     //TODO: if numCx = odd, then primary lines should not be set offCenter
//     //TODO setup minimum dims of 2x2

//     //draw center line
//     const line = {
//       x: 0,
//       y: 0,
//       speed: 2,
//     };

//     //line down center starting from top down
//     function drawLine(x1, x2, y1, y2) {
//       ctx.beginPath();
//       ctx.moveTo(x1, y1);
//       ctx.lineTo(x2, y2);
//       ctx.strokeStyle = "gray";
//       ctx.lineWidth = 1;
//       ctx.stroke();
//     }

//     function drawLine2() {
//       ctx.beginPath();
//       ctx.moveTo(centerX - spacing(3, 3), line.y);
//       ctx.lineTo(centerX - spacing(3, 3), -1 * height);
//       ctx.strokeStyle = "gray";
//       ctx.lineWidth = 1;
//       ctx.stroke();
//     }

//     function update() {
//       clearCanvas();
//       drawCanvasOutline();
//       drawLine(centerX, centerX, line.y, -1 * height);

//       //change position
//       line.y += line.speed;

//       requestAnimationFrame(update);
//     }

//     update();

//     function drawPlant() {
//       let plantRadius = 1;
//       // ctx.arc();
//     }

//     // animateControlLine(2, 2);
//   }, []);
