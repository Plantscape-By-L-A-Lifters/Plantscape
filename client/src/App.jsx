import axios from "axios";
import { useState, useEffect } from "react";
import { Link, Route, Routes } from "react-router-dom";

import Navbar from "./components/Navbar";
import Home from "./pages/Home";
import Plants from "./pages/Plants";
import StyleQuiz from "./pages/StyleQuiz";
import MyProfile from "./pages/MyProfile";
import ProjectForm from "./pages/ProjectForm";
import MyProject from "./pages/MyProject";
import Login from "./components/login.jsx"
function App() {
  return (
    <>
      <Navbar />
      <Routes>
        <Route exact path="/" element={<Home />} />
        <Route path="/plants" element={<Plants />} />
        <Route path="/quiz" element={<StyleQuiz />} />
        <Route path="/profile" element={<MyProfile />} />
        <Route path="/newproject" element={<ProjectForm />} />
        <Route path="/projects" element={<MyProject />} /> //should actually map
        through all projects
        <Route path = "/login" element ={<Login/>} />
      </Routes>
    </>
  );
}

export default App;
