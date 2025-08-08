import { useState, useContext } from "react";
import { DesignStyleContext } from "../context/DesignStyleContext";
import "./StyleQuiz.css";
import { styleQuizContent, styleQuizResults } from "../data/styleQuiz";
import { preProcessQuizData } from "../utils/preProcessQuizData";

// const styleQuizContent = [
//   {
//     question: "1",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287878/Brickelliacalifornica_hxewed.jpg",
//   },
//   {
//     question: "2",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753395839/Rosa_Ingrid_Bergman_2018-07-16_6611__cropped_i376sl.jpg",
//   },
//   {
//     question: "3",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282048/Copy_of_cone-flower_zqcl3s.jpg",
//   },
//   {
//     question: "4",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753790675/modern01_mtihwb.jpg",
//   },
//   {
//     question: "5",
//     imageUrl:
//       "https://res.cloudinary.com/dprixcop0/image/upload/v1753127016/spreading-japanese-plum-yew_c7753v.webp",
//   },
//   {
//     question: "6",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753790674/modern-minimal-04_wtosek.webp",
//   },
//   {
//     question: "7",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753790677/modernlush02_guoc3m.jpg",
//   },
//   {
//     question: "8",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753790672/classical01_kajhvg.jpg",
//   },
//   {
//     question: "9",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282055/hakone-grass_inabds.jpg",
//   },
//   {
//     question: "10",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287882/Hairy_Sunflower__1020466042_hodmut.jpg",
//   },
//   {
//     question: "11",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753790673/cottage_template_z6cd3b.webp",
//   },
//   {
//     question: "12",
//     imageUrl:
//       "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282044/anacacho-orchid-tree_fw1xpf.jpg",
//   },
// ];

// Main App component for the simple Yes/No quiz
export function StyleQuiz() {
  const { styles } = useContext(DesignStyleContext);
  // State to hold the pre-processed quiz data and style counts
  const [processedQuizData, setProcessedQuizData] = useState(null);
  // State to manage the current question index
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  // State to store the user's last answer (optional, for demonstration)
  const [lastAnswer, setLastAnswer] = useState(null);
  // State to track if the quiz is finished
  const [quizFinished, setQuizFinished] = useState(false);

  const [quizScore, setQuizScore] = useState({});

  //NEW

  const prepareQuiz = (quizData, styleDefs) => {
    try {
      const { enhancedQuizItems, styleTagCounts: counts } = preProcessQuizData(
        quizData,
        styleDefs
      );

      // Shuffle the enhanced quiz items and limit to 10 questions
      const shuffledItems = shuffleArray(enhancedQuizItems);
      const limitedItems = shuffledItems.slice(0, 10);

      return { limitedItems, counts };
    } catch (e) {
      console.error("Error preparing quiz data:", e.message);
      return null;
    }
  };

  // Use a useEffect to pre-process the data when the styles from the API are available
  useEffect(() => {
    if (styles.length > 0) {
      try {
        const processedData = preProcessQuizData(styleQuizContent, styles);
        setProcessedQuizData(processedData);

        // Initialize quizScore based on the processed styles
        const initialScore = {};
        styles.forEach((style) => {
          initialScore[style.design_style_name] = 0;
        });
        setQuizScore(initialScore);
      } catch (e) {
        console.error("Error pre-processing quiz data:", e.message);
        // You might want to handle this error more gracefully in your app
      }
    }
  }, [styles]);

  // Handle case where data is still loading
  if (!processedQuizData) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <h1 className="text-2xl font-bold text-gray-700">Loading Quiz...</h1>
      </div>
    );
  }

  const { enhancedQuizItems, styleTagCounts } = processedQuizData;
  // Get the current question and image based on the index
  const currentQuizItem = enhancedQuizItems[currentQuestionIndex];

  // NEW

  // Function to advance to the next question
  const goToNextQuestion = () => {
    // Check if there are more questions up to the 10th question (index 9)
    if (
      currentQuestionIndex < 9 &&
      currentQuestionIndex < styleQuizContent.length - 1
    ) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
      setLastAnswer(null); // Reset last answer display for the new question
    } else {
      // If 10 questions are answered or no more questions, mark quiz as finished
      setQuizFinished(true);
    }
  };

  // Function to handle 'Yes' button click
  const handleYesClick = () => {
    setLastAnswer("Yes");
    console.log(`Question ${currentQuestionIndex + 1}: Yes`);
    goToNextQuestion();
  };

  // Function to handle 'No' button click
  const handleNoClick = () => {
    setLastAnswer("No");
    console.log(`Question ${currentQuestionIndex + 1}: No`);
    goToNextQuestion();
  };

  // Function to restart the quiz
  const restartQuiz = () => {
    setCurrentQuestionIndex(0);
    setLastAnswer(null);
    setQuizFinished(false);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-100 to-purple-100 flex items-center justify-center p-4">
      <div className="bg-white p-8 rounded-xl shadow-2xl max-w-lg w-full text-center space-y-6 border border-gray-200">
        {quizFinished ? (
          // Display when the quiz is finished
          <div className="space-y-4">
            <h1 className="text-4xl font-extrabold text-green-700 font-inter">
              Congratulations!
            </h1>
            <p className="text-xl text-gray-700">
              Your design style is **Modern**
            </p>
            <button
              onClick={restartQuiz}
              className="px-8 py-3 bg-blue-600 text-white font-semibold rounded-lg shadow-md hover:bg-blue-700 focus:outline-none focus:ring-4 focus:ring-blue-300 transition transform hover:scale-105 duration-200"
            >
              Restart Quiz
            </button>
          </div>
        ) : (
          // Display during the quiz
          <>
            {/* Question Text */}
            <h1 className="text-3xl font-extrabold text-gray-800 mb-4 font-inter">
              {currentQuizItem.question}
            </h1>

            {/* Image Container */}
            <div className="w-full h-auto overflow-hidden rounded-lg shadow-md border border-gray-300">
              <img
                src={currentQuizItem.image_url}
                alt="Quiz Image"
                className="w-full h-full object-cover rounded-lg"
                // Fallback for image loading errors
                onError={(e) => {
                  e.target.onerror = null; // Prevents infinite loop
                  e.target.src =
                    "https://placehold.co/600x400/CCCCCC/333333?text=Image+Not+Found";
                }}
              />
            </div>

            {/* Buttons Container */}
            <div className="flex flex-col sm:flex-row justify-center gap-4 mt-6">
              <button
                onClick={handleYesClick}
                className="flex-1 px-8 py-3 bg-green-600 text-white font-semibold rounded-lg shadow-md hover:bg-green-700 focus:outline-none focus:ring-4 focus:ring-green-300 transition transform hover:scale-105 duration-200"
              >
                Yes
              </button>
              <button
                onClick={handleNoClick}
                className="flex-1 px-8 py-3 bg-red-600 text-white font-semibold rounded-lg shadow-md hover:bg-red-700 focus:outline-none focus:ring-4 focus:ring-red-300 transition transform hover:scale-105 duration-200"
              >
                No
              </button>
            </div>

            {/* Display user's last answer (optional) */}
            {lastAnswer && (
              <p className="mt-6 text-lg font-medium text-gray-700">
                You just answered:{" "}
                <span className="font-bold text-blue-600">{lastAnswer}</span>
              </p>
            )}
          </>
        )}
      </div>
    </div>
  );
}

export default StyleQuiz;

// const quizQuestions = [
//   {
//     id: 1,
//     question: "1",
//     imageUrl: "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282045/cedar-sedge_hwoyoo.jpg",
//   },
//   {
//     id: 2,
//     question: "2",
//     imageUrl: "https://res.cloudinary.com/dprixcop0/image/upload/v1753128204/boxwood_gqpns0.webp",
//   },
//   {
//     id: 3,
//     question: "3",
//     imageUrl: "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753790676/modernlush01_fpmdn7.jpg",
//   },
//   {
//     id: 4,
//     question: "4",
//     imageUrl: "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753790673/cottage_template_z6cd3b.webp",
//   },
//   {
//     id: 5,
//     question: "5",
//     imageUrl: "https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282059/white-autumn-sage_ekfmqt.jpg",
//   },
// ];

// export default function YesNoQuiz() {
//   // State to keep track of the current question index
//   const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
//   // State to determine if the quiz is complete
//   const [isQuizComplete, setIsQuizComplete] = useState(false);
//   // State to store answers (optional, but useful if you need to process results)
//   const [answers, setAnswers] = useState([]);

//   // Get the current question object based on the index
//   const currentQuestion = quizQuestions[currentQuestionIndex];

//   // Function to handle a 'Yes' or 'No' answer
//   const handleAnswer = (answer) => {
//     // Record the answer (optional)
//     setAnswers([...answers, { questionId: currentQuestion.id, answer }]);

//     // Move to the next question or complete the quiz
//     if (currentQuestionIndex < quizQuestions.length - 1) {
//       setCurrentQuestionIndex(currentQuestionIndex + 1);
//     } else {
//       setIsQuizComplete(true);
//     }
//   };

//   // Function to restart the quiz
//   const restartQuiz = () => {
//     setCurrentQuestionIndex(0);
//     setIsQuizComplete(false);
//     setAnswers([]); // Clear previous answers
//   };

//   return (
//     <div className="quiz-container-wrapper" style={quizContainerWrapperStyle}>
//       <div className="quiz-card" style={quizCardStyle}>
//         {isQuizComplete ? (
//           // Display completion message when quiz is done
//           <div style={completionMessageStyle}>
//             <h2>Quiz Complete!</h2>
//             <p>Thank you for taking the quiz. We hope this helps!</p>
//             {/* You can display results here based on the 'answers' state */}
//             {/* For example: <pre>{JSON.stringify(answers, null, 2)}</pre> */}
//             <button onClick={restartQuiz} style={buttonStyle}>Restart Quiz</button>
//           </div>
//         ) : (
//           // Display current question and image
//           <div style={questionDisplayStyle}>
//             <h2 style={questionTextStyle}>{currentQuestion.question}</h2>
//             {currentQuestion.imageUrl && (
//               <img
//                 src={currentQuestion.imageUrl}
//                 alt={`Question ${currentQuestion.id}`}
//                 style={imageStyle}
//                 onError={(e) => {
//                   e.target.onerror = null; // Prevent infinite loop
//                   e.target.src = "https://placehold.co/600x400/CCCCCC/000000?text=Image+Not+Found"; // Fallback image
//                 }}
//               />
//             )}
//             {!currentQuestion.imageUrl && (
//                 <p style={{color: '#666', fontSize: '1em'}}>No image provided for this question.</p>
//             )}
//             <div className="quiz-buttons" style={buttonsContainerStyle}>
//               <button onClick={() => handleAnswer('Yes')} style={buttonStyle}>Yes</button>
//               <button onClick={() => handleAnswer('No')} style={buttonDangerStyle}>No</button>
//             </div>
//           </div>
//         )}
//       </div>
//     </div>
//   );
// }

// const styleQuizContent = [
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

//Previous Code
// export default function Quiz() {
//   const { styles } = useContext(DesignStyleContext);
//   console.log("styles", styles);

//   const { plantCatalog, plantByName, loadingPlants } =
//     useContext(PlantCatalogContext);
//   console.log("plant Catalog", plantCatalog);

//   const [current, setCurrent] = useState(0);
//   const [isComplete, setIsComplete] = useState(false);

//   console.log("attempt", plantByName("coneflowers"));

//   const plantName = "conflowers"; // Example plant name

//   if (!loadingPlants) {
//     // Ensure the catalog is loaded before searching
//     const foundPlant = plantByName(plantName);

//     if (foundPlant) {
//       const imageUrl = foundPlant.image_url; // This is how you access the image_url
//       console.log(`Image URL for ${plantName}:`, imageUrl);
//       // You can then use imageUrl to display the image in your component
//       // <img src={imageUrl} alt={foundPlant.plant_name} />
//     } else {
//       console.log(`Plant "${plantName}" not found.`);
//     }
//   }

//   const handleAnswer = () => {
//     if (current < styleQuizContent.length - 1) {
//       setCurrent(current + 1);
//     } else {
//       setIsComplete(true);
//     }
//   };

//   const { image, question } = styleQuizContent[current];

//   const styleQuizContent = [
//     {
//       id: 1,
//       image: (
//         <img
//           src="coneflowers.image_ul"
//           alt="Corn Flowers"
//           className="quiz-image"
//         />
//       ),
//       title: "Image 1",
//     },
//     {
//       id: 2,
//       image: "/images/wildflower-style.jpg",
//       title: "Image 2",
//     },
//     {
//       id: 3,
//       image: "/images/symmetrical-design.jpg",
//       title: "Image 3",
//     },
//   ];

//   return (
//     <div className="quiz-wrapper">
//       <div className="quiz-container">
//         {isComplete ? (
//           <>
//             <h2 className="quiz-question">Thanks for taking the quiz!</h2>
//             <p>We hope this helped you get inspired 🌿</p>
//           </>
//         ) : (
//           <>
//             <h2 className="quiz-question">{question}</h2>
//             <img src={image} alt="quiz" className="quiz-image" />
//             <div className="quiz-buttons">
//               <button onClick={handleAnswer}>Yes</button>
//               <button onClick={handleAnswer}>No</button>
//             </div>
//           </>
//         )}
//       </div>
//     </div>
//   );
// }

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
