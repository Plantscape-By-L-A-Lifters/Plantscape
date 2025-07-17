import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import { BrowserRouter as Router } from "react-router-dom";
import { GardenPlanProvider } from "./context/GardenPlanContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <Router>
      <GardenPlanProvider>
        <App />
      </GardenPlanProvider>
    </Router>
  </React.StrictMode>
);
