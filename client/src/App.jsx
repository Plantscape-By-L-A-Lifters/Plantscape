import axios from "axios";
import { useState, useEffect } from "react";
import { Link, Route, Routes, useNavigate } from "react-router-dom";

import Navbar from "./components/Navbar";
import Home from "./pages/Home";
import Plants from "./pages/Plants";
import StyleQuiz from "./pages/StyleQuiz";
import MyProfile from "./pages/MyProfile";
import ProjectForm from "./pages/ProjectForm";
import MyProject from "./pages/MyProject";
import Login from "./components/login.jsx"
function App() {

const [user, setUser] = useState({})
const navigate = useNavigate()

  const getHeaders = () =>{
    return {
      headers: {
        authorization: window.localStorage.getItem('token')
      }
    }
  }

const attemptLogin = async() =>{
  const token = window.localStorage.getItem('token')
  if(token){
    try {
      const {data} = await axios.get('/api/authenticate/me', getHeaders())
      setUser(data)
    } catch (error) {
      console.log(error)
      window.localStorage.removeItem('token')
    }
  }
}

  const logout = () => {
    window.localStorage.removeItem('token')
    setUser({})
    navigate('/')
  }

  return (
    <>
      <Navbar user = {user} logout= {logout} />
      <Routes>
        <Route exact path="/" element={<Home />} />
        <Route path="/plants" element={<Plants />} />
        <Route path="/quiz" element={<StyleQuiz />} />
        <Route path="/profile" element={<MyProfile />} />
        <Route path="/newproject" element={<ProjectForm />} />
        <Route path="/projects" element={<MyProject />} /> //should actually map
        through all projects
        <Route path = "/login" element ={<Login attemptLogin = {attemptLogin}/>} />
      </Routes>
    </>
  );
}

export default App;
