import { NavLink } from "react-router-dom";

export default function Navbar() {
  return (
    <>
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
    </>
  );
}
