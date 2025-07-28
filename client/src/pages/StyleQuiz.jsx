import { useState } from "react";
import "./StyleQuiz.css";

const quizData = [
  {
    id: 1,
    image: <img src="/corn_flowers.jpeg" alt="Corn Flowers" className="quiz-image"/>,
    title: "Image 1",
  },
  {
    id: 2,
    image: "/images/wildflower-style.jpg",
    title: "Image 2",
  },
  {
    id: 3,
    image: "/images/symmetrical-design.jpg",
    title: "Image 3",
  },
];

export default function Quiz() {
  const [current, setCurrent] = useState(0);
  const [isComplete, setIsComplete] = useState(false);

  const handleAnswer = () => {
    if (current < quizData.length - 1) {
      setCurrent(current + 1);
    } else {
      setIsComplete(true);
    }
  };

  const { image, question } = quizData[current];

  return (
    <div className="quiz-wrapper">
      <div className="quiz-container">
        {isComplete ? (
          <>
            <h2 className="quiz-question">Thanks for taking the quiz!</h2>
            <p>We hope this helped you get inspired 🌿</p>
          </>
        ) : (
          <>
            <h2 className="quiz-question">{question}</h2>
            <img src={image} alt="quiz" className="quiz-image" />
            <div className="quiz-buttons">
              <button onClick={handleAnswer}>Yes</button>
              <button onClick={handleAnswer}>No</button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}







 