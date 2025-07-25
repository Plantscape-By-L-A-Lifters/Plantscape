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
import Register from "./components/register.jsx";
import GardenBedForm from "./pages/GardenBedForm";
import MyGardenBed from "./pages/MyGardenBed";

import { GardenBedProvider } from "./context/GardenBedContext";

function App() {
  const [user, setUser] = useState({});
  const [projects, setProjects] = useState([]);
  const navigate = useNavigate();

  const getHeaders = () => {
    return {
      headers: {
        authorization: window.localStorage.getItem("token"),
      },
    };
  };

  useEffect(() => {
    const getProjects = async () => {
      if (!user?.id) return;
      try {
        //console.log('Fetching projects for user ID:', user?.id) used for debugging
        const { data } = await axios.get(`/api/projects/MyProjects/${user.id}`);
        //console.log(data) used for debugging
        setProjects(data);
      } catch (error) {
        console.error(error);
      }
    };
    getProjects();
  }, [user.id]);

  const attemptLogin = async () => {
    const token = window.localStorage.getItem("token");
    if (token) {
      try {
        const { data } = await axios.get("/api/authenticate/me", getHeaders());
        setUser(data);
      } catch (error) {
        console.log(error);
        window.localStorage.removeItem("token");
      }
    }
  };

  useEffect(() => {
    attemptLogin();
  }, []);

  const logout = () => {
    window.localStorage.removeItem("token");
    setUser({});
    navigate("/");
  };

  return (
    <>
      <Navbar user={user} logout={logout} />
      <Routes>
        <Route exact path="/" element={<Home />} />
        <Route path="/plants" element={<Plants />} />
        <Route path="/quiz" element={<StyleQuiz />} />
        <Route path="/login" element={<Login attemptLogin={attemptLogin} />} />
        <Route
          path="/profile"
          element={
            <GardenBedProvider>
              <MyProfile user={user} projects={projects}/>
            </GardenBedProvider>
          }
        />
        <Route
          path="/newproject"
          element={
            <GardenBedProvider>
              <ProjectForm />
            </GardenBedProvider>
          }
        />
        <Route
          path="/myproject"
          element={
            <GardenBedProvider>
              <MyProject />
            </GardenBedProvider>
          }
        />
        <Route
          path="/projects"
          element={<MyProject projects={projects} setProjects={setProjects} />}
        />{" "}
        //CCRUZ: Justin, lets coordinate on the project state duplicate
        <Route
          path="/newgardenbed"
          element={
            <GardenBedProvider>
              <GardenBedForm />
            </GardenBedProvider>
          }
        />
        <Route
          path="/mygardenbed"
          element={
            <GardenBedProvider>
              <MyGardenBed />
            </GardenBedProvider>
          }
        />

        <Route path="/register" element={<Register/>}/>

      </Routes>
    </>
  );
}

export default App;
