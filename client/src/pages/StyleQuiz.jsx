import { useState, useContext } from "react";
import { DesignStyleContext } from "../context/DesignStyleContext";
import { PlantCatalogContext } from "../context/PlantCatalogContext";
import "./StyleQuiz.css";

// const quizData = [
//   {
//     id: 1,
//     image: (
//       <img src="/corn_flowers.jpeg" alt="Corn Flowers" className="quiz-image" />
//     ),
//     title: "Image 1",
//   },
//   {
//     id: 2,
//     image: "/images/wildflower-style.jpg",
//     title: "Image 2",
//   },
//   {
//     id: 3,
//     image: "/images/symmetrical-design.jpg",
//     title: "Image 3",
//   },
// ];

export default function Quiz() {
  const { styles } = useContext(DesignStyleContext);
  console.log("styles", styles);

  const { plantCatalog, plantByName, loadingPlants } =
    useContext(PlantCatalogContext);
  console.log("plant Catalog", plantCatalog);

  const [current, setCurrent] = useState(0);
  const [isComplete, setIsComplete] = useState(false);

  console.log("attempt", plantByName("coneflowers"));

  const plantName = "coneflowers"; // Example plant name

  if (!loadingPlants) {
    // Ensure the catalog is loaded before searching
    const foundPlant = plantByName(plantName);

    if (foundPlant) {
      const imageUrl = foundPlant.image_url; // This is how you access the image_url
      console.log(`Image URL for ${plantName}:`, imageUrl);
      // You can then use imageUrl to display the image in your component
      // <img src={imageUrl} alt={foundPlant.plant_name} />
    } else {
      console.log(`Plant "${plantName}" not found.`);
    }
  }

  const handleAnswer = () => {
    if (current < quizData.length - 1) {
      setCurrent(current + 1);
    } else {
      setIsComplete(true);
    }
  };

  const { image, question } = quizData[current];

  const quizData = [
    {
      id: 1,
      image: (
        <img
          src="coneflowers.image_url"
          alt="Coneflowers"
          className="quiz-image"
        />
      ),
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

//------  code from gemini to absorb
// import React, { useContext, useState, useEffect, useCallback } from 'react';
// import { usePlantCatalog } from '../context/PlantCatalogContext'; // Adjust path as needed

// export default function StyleQuiz() {
//   // Access plantByName and loadingPlants from the PlantCatalogContext
//   const { plantByName, loadingPlants } = usePlantCatalog();

//   const [quizQuestions, setQuizQuestions] = useState([]);
//   const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
//   const [selectedAnswers, setSelectedAnswers] = useState({});
//   const [quizResults, setQuizResults] = useState(null);

//   // --- NEW: Helper function to get a plant's image URL by name ---
//   // This function uses the plantByName from context to find the plant
//   // and then returns its image_url.
//   const getPlantImageUrlByName = useCallback((plantName) => {
//     if (loadingPlants) {
//       console.warn("Plant catalog is still loading. Cannot get image URL for:", plantName);
//       return null; // Or a placeholder URL
//     }
//     const plant = plantByName(plantName);
//     if (plant && plant.image_url) {
//       return plant.image_url;
//     }
//     console.warn(`Image URL not found for plant: ${plantName}`);
//     return null; // Or a default/placeholder image URL
//   }, [plantByName, loadingPlants]); // Dependencies: plantByName and loadingPlants

//   // Example of how you might use it (e.g., in a useEffect or a render function)
//   useEffect(() => {
//     // Simulate loading quiz questions which might reference plant names
//     const questions = [
//       {
//         id: 1,
//         text: "Which plant do you prefer?",
//         options: [
//           { value: "optionA", label: "Boxwood" },
//           { value: "optionB", label: "Lavender" },
//         ],
//       },
//       // ... more questions
//     ];
//     setQuizQuestions(questions);

//     // Example usage: Pre-fetch or display an image for a question
//     if (!loadingPlants) { // Ensure plants are loaded before trying to get URLs
//       const boxwoodImageUrl = getPlantImageUrlByName("boxwood");
//       console.log("Boxwood Image URL for quiz:", boxwoodImageUrl);
//       // You would typically use this URL in an <img> tag in your JSX
//     }
//   }, [loadingPlants, getPlantImageUrlByName]); // Re-run when plants load or helper changes

//   const handleAnswer = (questionId, answer) => {
//     setSelectedAnswers((prev) => ({ ...prev, [questionId]: answer }));
//   };

//   const handleSubmitQuiz = () => {
//     // Logic to process answers and determine results
//     setQuizResults("Your ideal style is..."); // Placeholder
//   };

//   if (loadingPlants) {
//     return <div>Loading plant catalog for quiz...</div>;
//   }

//   if (quizQuestions.length === 0) {
//     return <div>No quiz questions available.</div>;
//   }

//   const currentQuestion = quizQuestions[currentQuestionIndex];

//   return (
//     <div>
//       <h1>Style Quiz</h1>
//       {quizResults ? (
//         <div>
//           <h2>Quiz Complete!</h2>
//           <p>{quizResults}</p>
//         </div>
//       ) : (
//         <div>
//           <h3>{currentQuestion.text}</h3>
//           <div>
//             {currentQuestion.options.map((option) => (
//               <div key={option.value}>
//                 <label>
//                   <input
//                     type="radio"
//                     name={`question-${currentQuestion.id}`}
//                     value={option.value}
//                     checked={selectedAnswers[currentQuestion.id] === option.value}
//                     onChange={() => handleAnswer(currentQuestion.id, option.value)}
//                   />
//                   {option.label}
//                   {/* Example of displaying image next to option */}
//                   {getPlantImageUrlByName(option.label) && (
//                     <img
//                       src={getPlantImageUrlByName(option.label)}
//                       alt={option.label}
//                       style={{ width: '100px', height: '100px', objectFit: 'cover', marginLeft: '10px' }}
//                     />
//                   )}
//                 </label>
//               </div>
//             ))}
//           </div>
//           {currentQuestionIndex < quizQuestions.length - 1 ? (
//             <button onClick={() => setCurrentQuestionIndex((prev) => prev + 1)}>
//               Next Question
//             </button>
//           ) : (
//             <button onClick={handleSubmitQuiz}>Submit Quiz</button>
//           )}
//         </div>
//       )}
//     </div>
//   );
// }
