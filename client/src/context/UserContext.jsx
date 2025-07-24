// CCRUZ: Currently not using context for user state.  here is a starting point if we want to incorporate it in the future.

// import { createContext, useState, useEffect } from "react";
// import axios from "axios";

// export const UserContext = createContext();

// export const UserProvider = ({ children }) => {
//   const [user, setUser] = useState(null); // will hold { id, email, isAdmin, ... }
//   const [loading, setLoading] = useState(true);

//   const isAuthenticated = !!user;
//   const isAdmin = user?.isAdmin || false;

//   // Optional: auto-fetch logged in user if token/session exists
//   useEffect(() => {
//     const fetchUser = async () => {
//       try {
//         const { data } = await axios.get("/api/me");
//         setUser(data);
//       } catch (err) {
//         console.warn("User not logged in", err);
//         setUser(null);
//       } finally {
//         setLoading(false);
//       }
//     };

//     fetchUser();
//   }, []);

//   const logoutUser = async () => {
//     try {
//       await axios.post("/api/logout");
//       setUser(null);
//     } catch (err) {
//       console.error("Logout failed", err);
//     }
//   };

//   return (
//     <UserContext.Provider
//       value={{
//         user,
//         setUser,
//         isAuthenticated,
//         isAdmin,
//         loading,
//         logoutUser,
//       }}
//     >
//       {children}
//     </UserContext.Provider>
//   );
// };

//USAGE IN COMPONENTS - EXAMPLE:
// import { useContext } from "react";
// import { UserContext } from "../context/UserContext";

// const Dashboard = () => {
//   const { user, isAdmin, isAuthenticated, logoutUser } = useContext(UserContext);

//   if (!isAuthenticated) return <p>Please log in</p>;

//   return (
//     <div>
//       <h1>Welcome, {user.name}</h1>
//       {isAdmin && <p>You have admin privileges</p>}
//       <button onClick={logoutUser}>Log out</button>
//     </div>
//   );
// };
