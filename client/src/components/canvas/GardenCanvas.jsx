import { useRef, useEffect, useContext } from "react";
import { GardenPlanContext } from "../../context/GardenPlanContext";
import { animateGridLines } from "../../utils/canvasGridAnimation";

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
    ctx.fillStyle = "white";
    // ctx.strokeRect(0, 0, width, height);
    ctx.fillRect(0, 0, width, height);

    // Animate the grid
    animateGridLines(ctx, width, height, 4, 3);

    // Draw each plant as a circle
    placedPlants.forEach((plant) => {
      const x = plant.x * scale;
      const y = plant.y * scale;
      const radius = (plant.diameter / 2) * scale;

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

//future algorithm considerations
//  givens:
//  - bed length (determines max diameter of plants )
//  - bed depth
//  - style (determines minimal grid spacing & spacing buffer)
//  - style density (determines spacing buffer between plants)
//    - lush at 1
//    - balanced at 1.2
//   - open at min 1.4
//  - light conditions

//output:
// recommended layout
// recommended plants

//length & style determine maximum plant diameter
//ex. 8' long classical - 8 / 4Cx min = 2' max plant diameter for largest plant

//if style is modern numCx must be minimum of 3 and must be odd.
//if style is classical numCx must be minimum of 4 and must be even
//if style is cottage numCx must be minimum of 3

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

//before optimizing code for centerlines
//find the center of the canvas
// const centerX = width / 2;
// const centerY = height / 2;

// //determine grid spacing
// function gridSpacingX(numCx) {
//   //divide bed length by largest plant diameter
//   return Math.floor(width / numCx);
// }

// function gridSpacingY(numCy) {
//   return Math.floor(height / numCy);
// }

// function isOdd(number) {
//   return Math.abs(number % 2) === 1;
// }

//if isOdd(spacingX) {setOffCenter}}
//TODO: if numCx = odd, then primary lines should not be set offCenter
//TODO setup minimum dims of 2x2

// // line down center starting from top down
// function drawLine(x1, x2, y1, y2) {
//   ctx.beginPath();
//   ctx.moveTo(x1, y1);
//   ctx.lineTo(x2, y2);
//   ctx.strokeStyle = "gray";
//   ctx.lineWidth = 1;
//   ctx.stroke();
// }

// let spacingX = gridSpacingX(3);
// //for even numbers
// // drawLine(centerX, centerX, 0, height);
// // drawLine(centerX - spacingX, centerX - spacingX, 0, height);
// // drawLine(centerX + spacingX, centerX + spacingX, 0, height);

// // for odd numbers
// drawLine(centerX - spacingX / 2, centerX - spacingX / 2, 0, height);
// drawLine(centerX + spacingX / 2, centerX + spacingX / 2, 0, height);

//before optimizing with grid animation
//  function drawGridLines({ ctx, axis, count }) {
//       if (count < 2) return;

//       const fullSize = axis === "x" ? width : height;
//       const spacing = fullSize / count;

//       // Start at 1 so we skip the first edge, end at count - 1 to skip last edge
//       for (let i = 1; i < count; i++) {
//         const pos = i * spacing;

//         if (axis === "x") {
//           drawLine(pos, 0, pos, height);
//         } else {
//           drawLine(0, pos, width, pos);
//         }
//       }
//     }

//     function drawLine(x1, y1, x2, y2, color = "gray") {
//       ctx.beginPath();
//       ctx.moveTo(x1, y1);
//       ctx.lineTo(x2, y2);
//       ctx.strokeStyle = color;
//       ctx.lineWidth = 1;
//       ctx.stroke();
//     }

//     drawGridLines({
//       ctx,
//       axis: "x",
//       count: 4,
//     });

//     drawGridLines({
//       ctx,
//       axis: "y",
//       count: 3,
//     });
