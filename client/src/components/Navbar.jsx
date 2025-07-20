import { NavLink } from "react-router-dom";
import "./navbar.css";

export default function Navbar({user, logout}) {
  return (
    <>
    {
  user.id ?
  (<>      <span>PlantScape</span>
      <NavLink to="/" className={({ isActive }) => (isActive ? "active" : "")}>
        Home
      </NavLink>
       {"  "}
      <NavLink
        to="/plants"
        className={({ isActive }) => (isActive ? "active" : "")}
      >
        Plants
      </NavLink>
     {"  "}
      <NavLink
        to="/quiz"
        className={({ isActive }) => (isActive ? "active" : "")}
      >
        Style Quiz
      </NavLink>
      {"  "}
      <NavLink
        to="/profile"
        className={({ isActive }) => (isActive ? "active" : "")}
      >
        My Profile
      </NavLink>
       {"  "}
      <button onClick={logout}>logout</button>
      </>


  ) : ( 
  <>
          <span>PlantScape</span>  {"  "}
      <NavLink to="/" className={({ isActive }) => (isActive ? "active" : "")}>
        Home
      </NavLink>
       {"  "}
      <NavLink
        to="/plants"
        className={({ isActive }) => (isActive ? "active" : "")}
      >
        Plants
      </NavLink>
       {"  "}
      <NavLink
        to="/quiz"
        className={({ isActive }) => (isActive ? "active" : "")}
      >
        Style Quiz
      </NavLink>
       {"  "}
      <NavLink
        to="/profile"
        className={({ isActive }) => (isActive ? "active" : "")}
      >
        My Profile
      </NavLink>
       {"  "}
      <NavLink
        to="/Login"
        className={({ isActive }) => (isActive ? "active" : "")}
      >
        Login
      </NavLink>
      </>
  )
}
    </>

  );
}
