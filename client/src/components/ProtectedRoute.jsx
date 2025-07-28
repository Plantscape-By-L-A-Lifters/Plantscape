// components/ProtectedRoute.jsx
import React, { useContext } from "react";
import { Navigate, Outlet } from "react-router-dom";
import { UserContext } from "../UserContext"; // Adjust path as needed

const ProtectedRoute = ({ children }) => {
  const { isLoggedIn, loading } = useContext(UserContext); // Assuming UserContext provides isLoggedIn and loading

  // If UserContext is still loading authentication status, show nothing or a loading spinner
  if (loading) {
    return <p>Loading authentication...</p>; // Or a more sophisticated loading spinner
  }

  // If the user is logged in, render the child routes/components
  if (isLoggedIn) {
    return children ? children : <Outlet />; // Use Outlet for nested routes, or children for direct element
  } else {
    // If not logged in, redirect to the login page
    return <Navigate to="/login" replace />;
  }
};

export default ProtectedRoute;
