import { createContext, useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

export const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const [user, setUser] = useState({}); // will hold { id, email, isAdmin, ... }
  const navigate = useNavigate();

  const getHeaders = () => {
    const token = window.localStorage.getItem("token");
    // Return an object with headers if token exists, otherwise an empty object
    // This prevents sending 'undefined' as authorization header
    return token ? { headers: { authorization: token } } : {};
  };

  const attemptLogin = async () => {
    const token = window.localStorage.getItem("token");
    if (token) {
      try {
        const { data } = await axios.get("/api/authenticate/me", getHeaders());
        setUser(data);
      } catch (error) {
        console.error("Authentication failed:", error); // Use console.error for errors
        window.localStorage.removeItem("token");
        setUser({}); // Clear user on auth failure
      }
    }
  };

  useEffect(() => {
    attemptLogin();
  }, []); //Runs once on mount

  const logout = () => {
    window.localStorage.removeItem("token");
    setUser({}); // Clear user state
    navigate("/"); // Redirect to home page
  };

  // Provide all necessary values to consumers
  return (
    <UserContext.Provider
      value={{ user, setUser, attemptLogin, logout, getHeaders }}
    >
      {children}
    </UserContext.Provider>
  );
};

export default UserProvider;
