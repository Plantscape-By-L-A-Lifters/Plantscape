import { useRef, useEffect } from "react";

export default function Canvas(props) {
  const canvasRef = useRef(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    const ctx = canvas.getContext("2d");
    const bedWidth = props.width;
    const bedHeight = props.height;

    const clearCanvas = () => {
      ctx.clearRect(0, 0, bedWidth, bedHeight);
    };

    const drawCanvasOutline = () => {
      //draw canvas outline
      ctx.strokeStyle = "black";
      ctx.strokeRect(0, 0, bedWidth, bedHeight);
    };
    //find the center of the canvas
    const centerX = bedWidth / 2;
    const centerY = bedHeight / 2;

    function isOdd(number) {
      return Math.abs(number % 2) === 1; // Use Math.abs for consistent handling of negative numbers
    }

    //determine spacing
    function spacingX(numCx) {
      return Math.floor(bedWidth / numCx);
    }

    function spacingY(numCy) {
      return Math.floor(bedHeight / numCy);
    }

    function remainderX(numCx) {
      return bedWidth % numCx;
    }

    function remainderY(numCy) {
      return bedHeight % numCy;
    }
    //if isOdd(spacingX) {setOffCenter}}
    //TODO: if numCx = odd, then primary lines should not be set offCenter
    //TODO setup minimum dims of 2x2

    //draw center line
    const line = {
      x: 0,
      y: 0,
      speed: 2,
    };

    //line down center starting from top down
    function drawLine(x1, x2, y1, y2) {
      ctx.beginPath();
      ctx.moveTo(x1, y1);
      ctx.lineTo(x2, y2);
      ctx.strokeStyle = "gray";
      ctx.lineWidth = 1;
      ctx.stroke();
    }

    function drawLine2() {
      ctx.beginPath();
      ctx.moveTo(centerX - spacing(3, 3), line.y);
      ctx.lineTo(centerX - spacing(3, 3), -1 * bedHeight);
      ctx.strokeStyle = "gray";
      ctx.lineWidth = 1;
      ctx.stroke();
    }

    function update() {
      clearCanvas();
      drawCanvasOutline();
      drawLine(centerX, centerX, line.y, -1 * bedHeight);

      //change position
      line.y += line.speed;

      requestAnimationFrame(update);
    }

    update();

    function drawPlant() {
      let plantRadius = 1;
      // ctx.arc();
    }

    // animateControlLine(2, 2);
  }, []);

  return <canvas ref={canvasRef} width={props.width} height={props.height} />;
}
