import React, { useContext, useEffect } from "react";
import { Link } from "react-router-dom";
import { UserContext } from "../context/UserContext"; // Adjust path as needed
import { ProjectContext } from "../context/ProjectContext"; // Adjust path as needed

const MyProjects = () => {
  const { user } = useContext(UserContext);
  const {
    projects,
    fetchProjects, // Function to re-fetch all projects
    // You might add a loading state here if ProjectContext had one for its initial fetchProjects
    // e.g., loadingProjects: from ProjectContext
  } = useContext(ProjectContext);

  // Although ProjectContext's useEffect already calls fetchProjects on user.id change,
  // this useEffect ensures that if a user directly navigates to /myprojects,
  // the data is fresh or fetched if not already.
  useEffect(() => {
    if (user?.id && projects.length === 0) {
      // Only fetch if user is logged in and projects are empty
      fetchProjects();
    }
  }, [user?.id, fetchProjects, projects.length]); // Add projects.length to re-evaluate if projects become empty

  if (!user.id) {
    return <div>Please log in to view your projects.</div>;
  }

  // You might want a loading state here from ProjectContext if you add one
  // if (loadingProjects) {
  //   return <div>Loading your projects...</div>;
  // }

  return (
    <div>
      <h2>My Projects</h2>
      <Link to="/newproject">Create New Project</Link>

      {projects.length === 0 ? (
        <p>You don't have any projects yet. Create one to get started!</p>
      ) : (
        <ul>
          {projects.map((project) => (
            <li key={project.id}>
              {/* Link to the detailed MyProject component */}
              <Link to={`/myproject/${project.id}`}>
                {project.project_name}
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default MyProjects;
